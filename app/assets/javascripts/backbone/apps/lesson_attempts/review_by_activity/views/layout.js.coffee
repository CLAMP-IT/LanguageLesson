@LanguageLesson.module "LessonAttemptsApp.ReviewByActivity", (ReviewByActivity, App, Backbone, Marionette, $, _) ->
  class ReviewByActivity.Layout extends App.Views.Layout
    template: "lesson_attempts/review_by_activity/templates/layout"

    regions:
      infoRegion: "#info-region"
      matrixRegion: "#matrix-region"
