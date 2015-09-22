@LanguageLesson.module "LessonAttemptsApp.ReviewByActivity", (ReviewByActivity, App, Backbone, Marionette, $, _) ->
  class ReviewByActivity.QuestionAttemptResponses extends App.Views.CollectionView
    childView: ReviewByActivity.QuestionAttemptResponse

    modelEvents:
      "updated" : "render"
