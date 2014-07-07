@LanguageLesson.module "LessonAttemptsApp.Review", (Review, App, Backbone, Marionette, $, _) ->
  class Review.Layout extends App.Views.Layout
    template: "lesson_attempts/review/templates/review_layout"

    regions:
      contextRegion: "#context-region"
      infoRegion: "#info-region"
      questionAttemptsRegion: "#question-attempts-region"
      questionAttemptLayoutRegion: "#question-attempt-layout-region"
