@LanguageLesson.module "LessonAttemptsApp.Review", (Review, App, Backbone, Marionette, $, _) ->
  class Review.LessonAttemptInfo extends App.Views.ItemView
    template: "lesson_attempts/review/templates/lesson_attempt_info"
