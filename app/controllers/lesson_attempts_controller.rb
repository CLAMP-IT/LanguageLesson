class LessonAttemptsController < ApplicationController
  def index
    @lesson_attempts = LessonAttempt.all

    respond_to do |format|
    end
  end

  def by_activity
    @activity = Activity.find params[:activity_id]

    @lesson = Lesson.find @activity.doable_id

    @questions = Question.for_lesson(@lesson)
    
    @users = User
             .with_question_attempts_for_activity(@activity)
             .includes(question_attempts: [:recording, question_attempt_responses: :recording])
             .order(:name, "question_attempt_responses.mark_start")
  end

  def by_lesson_and_user
    @lesson_attempt = LessonAttempt
                      .includes(question_attempts: :question)
                      .references(:question_attempts)
                      .order('questions.row_order')
                      .where(lesson_id: params[:lesson_id])
                      .where(user_id: params[:user_id])
                      .first

    render json: {} unless @lesson_attempt
  end
  
  def show
    @lesson_attempt = LessonAttempt
                      .includes(question_attempts: :question)
                      .references(:question_attempts)
                      .order('questions.row_order')
                      .find(params[:id])

    respond_to do |format|
      format.json
    end
  end

  def new
    @lesson_attempt = LessonAttempt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lesson_attempt }
    end
  end

  def edit
    @lesson_attempt = LessonAttempt.find(params[:id])
  end

  def create
    @lesson_attempt = LessonAttempt.new(lesson_attempt_params)

    respond_to do |format|
      if @lesson_attempt.save
        format.html { redirect_to @lesson_attempt, notice: 'Lesson was successfully created.' }
        format.json { render 'create' }
      else
        format.html { render action: "new" }
        format.json { render json: @lesson_attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @lesson_attempt = LessonAttempt.find(params[:id])

    respond_to do |format|
      if @lesson.update_attributes(params[:lesson_attempt])
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lesson_attempt = LessonAttempt.find(params[:id])
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to lessons_url }
      format.json { head :no_content }
    end
  end

  def lesson_attempt_params
    params.require(:lesson_attempt).permit(:activity_id, :lesson_id, :user_id)
  end
end
