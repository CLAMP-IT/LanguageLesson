@LanguageLesson.module "LessonAttemptsApp.ReviewByActivity", (ReviewByActivity, App, Backbone, Marionette, $, _) ->
  class ReviewByActivity.QuestionBox extends App.Views.ItemView
    template: "lesson_attempts/review_by_activity/templates/question_box"

    events:
      'click': 'respondToQuestionAttempt'

    className: ->
      App.request 'lesson_attempt:review_by_activity:determine_question_state', @model

    respondToQuestionAttempt: ->
      @trigger 'find:question:attempt', @model
      App.vent.trigger 'lesson_attempt:review_by_activity:show_question_attempt', @model.get('question_attempt')
