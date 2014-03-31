class Lti::QuestionAttemptsController < Lti::LtiController
  before_filter :fetch_user

  def new
    render nothing: true
  end

  def create
    attempt = QuestionAttempt.create(:lesson_attempt_id => params[:lesson_attempt_id],
                                     :question_id => params[:question_id],
                                     :user_id => session[:user_id])

    recording = Recording.create(params[:recording])
    
    recording.recordable = attempt
    recording.save

    render nothing: true
  end
end
