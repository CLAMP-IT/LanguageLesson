@LanguageLesson.module "LessonAttemptsApp.Review", (Review, App, Backbone, Marionette, $, _) ->
  class Review.QuestionAttemptButton extends App.Views.ItemView
    template: "lesson_attempts/review/templates/_question_attempt_button"
    tagName: "li"

    className: =>
      return 'responded' unless @model.responded
      
    modelEvents:
      "updated" : "render"

    triggers:
      "click [data-js-respond]" : "respond:question_attempt:clicked"
      "click" : "respond:question_attempt:clicked"
