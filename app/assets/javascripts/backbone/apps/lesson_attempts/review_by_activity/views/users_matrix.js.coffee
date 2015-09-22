@LanguageLesson.module "LessonAttemptsApp.ReviewByActivity", (ReviewByActivity, App, Backbone, Marionette, $, _) ->
  class ReviewByActivity.UserMatrix extends App.Views.CompositeView
    template: "lesson_attempts/review_by_activity/templates/user_matrix"

    childView: ReviewByActivity.UserRow

    childViewContainer: '#user-rows'
