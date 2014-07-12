@LanguageLesson.module "LessonAttemptsApp.Review", (Review, App, Backbone, Marionette, $, _) ->
  class Review.QuestionAttempts extends App.Views.CompositeView
    template: "lesson_attempts/review/templates/_question_attempts"
    childView: Review.QuestionAttemptButton
    childViewContainer: "#questions-list"
