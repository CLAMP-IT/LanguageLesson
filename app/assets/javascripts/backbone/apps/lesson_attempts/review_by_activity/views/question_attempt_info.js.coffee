@LanguageLesson.module "LessonAttemptsApp.ReviewByActivity", (ReviewByActivity, App, Backbone, Marionette, $, _) ->
  class ReviewByActivity.QuestionAttemptInfo extends App.Views.ItemView
    template: "lesson_attempts/review_by_activity/templates/question_attempt_info"

