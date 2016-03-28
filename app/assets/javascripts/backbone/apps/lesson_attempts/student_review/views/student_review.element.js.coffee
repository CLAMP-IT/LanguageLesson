//= require ./student_review.question_attempt_response

@LanguageLesson.module "LessonAttemptsApp.StudentReview", (StudentReview, App, Backbone, Marionette, $, _) ->
  class StudentReview.Element extends App.Views.CompositeView
    template: "lesson_attempts/student_review/templates/_bare_element"

    childView: StudentReview.QuestionAttemptResponse
    childViewContainer: '#responses-list'

    tagName: 'div'

    initialize: (options) ->
      @currentUser = options.currentUser

      @currentAttempt = options.currentAttempt
