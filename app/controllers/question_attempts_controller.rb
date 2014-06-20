class QuestionAttemptsController < ApplicationController
  #before_filter :fetch_user

  def new
    render nothing: true
  end

  def create
    attempt = QuestionAttempt.new(:lesson_attempt_id => params[:lesson_attempt_id],
                                  :question_id => params[:question_id],
                                  :user_id => session[:user_id])

    success = attempt.save
    
    recording = Recording.create(params[:recording])
    
    recording.recordable = attempt
    
    success = success && recording.save

    respond_to do |format|
      if @attempt.save
        format.html { render nothing: true }
        format.json { render json: @lesson_attempt, status: :created, location: @lesson_attempt }
      else
        format.html { render action: "new" }
        format.json { render json: @lesson_attempt.errors, status: :unprocessable_entity }
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

    #respond_to do |format|
    #  if success
    #    format.json { render json: @question_attempt }#, status: :created }
    #  else
    #    format.json { render json: question_attempt.errors, status: :unprocessable_entity }
    #end
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
