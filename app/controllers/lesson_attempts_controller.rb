class LessonAttemptsController < ApplicationController
  # GET /lessons
  # GET /lessons.json
  def index
    @lesson_attempts = LessonAttempt.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lesson_attempts }
    end
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @lesson_attempt = LessonAttempt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson_attempt }
    end
  end

  # GET /lessons/new
  # GET /lessons/new.json
  def new
    @lesson_attempt = LessonAttempt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lesson_attempt }
    end
  end

  # GET /lessons/1/edit
  def edit
    @lesson_attempt = LessonAttempt.find(params[:id])
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson_attempt = LessonAttempt.new(params[:lesson_attempt])

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
        format.json { render json: @lesson, status: :created, location: @lesson_attempt }
      else
        format.html { render action: "new" }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lessons/1
  # PUT /lessons/1.json
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

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson_attempt = LessonAttempt.find(params[:id])
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to lessons_url }
      format.json { head :no_content }
    end
  end
end
