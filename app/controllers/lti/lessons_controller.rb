class Lti::LessonsController < Lti::LtiController
  def start_lesson
    user = User.find(session[:user_id])
    @lesson = Lesson.find(params[:lesson_id])
  end
end
