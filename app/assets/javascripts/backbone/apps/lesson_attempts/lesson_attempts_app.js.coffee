@LanguageLesson.module "LessonAttemptsApp", (LessonAttemptsApp, App, Backbone, Marionette, $, _) ->
  class LessonAttemptsApp.Router extends Marionette.AppRouter
    appRoutes:
      "lesson_attempts" : "list"
      "lesson_attempts/student_review" : "studentReview"
      "lesson_attempts/:id" : "show"
      "lesson_attempts/:id/review" : "review"
      "lesson_attempts/:activity_id/review_by_activity" : "reviewByActivity"

  API =
    list: ->
      controller = new LessonAttemptsApp.List.Controller
      controller.listLessonAttempts()

    show: (id) ->
      controller = new LessonAttemptsApp.Show.Controller
      controller.showLessonAttempt(id)

    review: (id) ->
      controller = new LessonAttemptsApp.Review.Controller
      controller.review(id)

    reviewQuestionAttempt: (question_attempt) ->
      controller = new LessonAttemptsApp.ReviewQuestionAttempt.Controller
      controller.review(question_attempt)

    reviewByActivity: (activity_id) ->
      controller = new LessonAttemptsApp.ReviewByActivity.Controller
      controller.review(activity_id)

    studentReview:  ->
      controller = new LessonAttemptsApp.StudentReview.Controller
      controller.review()

  App.addInitializer ->
    new LessonAttemptsApp.Router
      controller: API

  App.vent.on "edit:lesson_attempt:clicked", (lesson_attempt) ->
    App.navigate "lesson_attempts/#{lesson_attempt.attributes.id}/review"
    API.review lesson_attempt.get('id')

  App.vent.on "respond:question_attempt:clicked", (question_attempt) ->
    API.reviewQuestionAttempt question_attempt
