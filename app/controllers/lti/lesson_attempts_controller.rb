class Lti::LessonAttemptsController < Lti::LtiController
  before_filter :fetch_user

  def fetch_user  
    @user = User.find(session[:user_id])
  end

  def start_attempt
  
    @lesson  = Lesson.find(params[:lesson_id])

    @lesson_attempt = LessonAttempt.create(:user => @user,
                                           :lesson => @lesson)

    session[:lesson_attempt_id] = @lesson_attempt.id

    @page_element = @lesson_attempt.lesson.pages.first.page_elements.first

    redirect_to lti_show_lesson_attempt_page_element_path(@lesson_attempt, @page_element)
  end

  def show_page_element
    @lesson_attempt = LessonAttempt.find(session[:lesson_attempt_id])
    #@page_element = @lesson_attempt.lesson.pages.first.page_elements.first
    @page_element = PageElement.find(params[:page_element_id])

    @position = @lesson_attempt.lesson.pages.first.page_elements.index(@page_element)

    @previous_page_element = @lesson_attempt.lesson.pages.first.page_elements[@position - 1] unless (@position == 0) 

    @next_page_element = @lesson_attempt.lesson.pages.first.page_elements[@position + 1] 
  end
end
