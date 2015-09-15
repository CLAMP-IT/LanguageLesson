class QuestionAttemptsController < ApplicationController
  #before_filter :fetch_user

  def new
    render nothing: true
  end

  def create
    @attempt = QuestionAttempt.new(question_attempt_params)

    respond_to do |format|
      if @attempt.save
        format.json { render json: @attempt, status: :created, location: @lesson_attempt }
      else
        format.json { render json: @attempt.errors, status: :unprocessable_entity }
      end
    end    
  end

  def add
    attempt = QuestionAttempt.new(question_attempt_params)

    success = attempt.save
    
    recording = Recording.create(recording_params)
    
    recording.recordable = attempt
    
    success = success && recording.save

    respond_to do |format|
      if success
        format.json { render json: attempt, status: :created }
      else
        format.json { render json: attempt.errors, status: :unprocessable_entity }
      end
    end    
  end
  
  def find_by_lesson_attempt_question_and_user
    @question_attempt = QuestionAttempt.where("lesson_attempt_id = ? and question_id = ? and user_id = ?",
                                             params[:lesson_attempt_id],
                                             params[:question_id],
                                             params[:user_id]).first
  end    

  def update
    @question_attempt = QuestionAttempt.find(params[:id])

    respond_to do |format|
      if @question_attempt.update_attributes(question_attempt_params)
        format.json { head :no_content }
      else
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # Only allow a trusted parameter "white list" through.
  def question_attempt_params
    params.require(:question_attempt).permit!
  end

  # Only allow a trusted parameter "white list" through.
  def recording_params
    params.require(:recording).permit!
  end  
end
