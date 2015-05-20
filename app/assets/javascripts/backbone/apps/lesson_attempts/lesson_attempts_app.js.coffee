@LanguageLesson.module "LessonAttemptsApp", (LessonAttemptsApp, App, Backbone, Marionette, $, _) ->
  class LessonAttemptsApp.Router extends Marionette.AppRouter
    appRoutes:
      "lesson_attempts" : "list"
      "lesson_attempts/:id" : "show"
      "lesson_attempts/:id/review" : "review"

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
      #controller = new QuestionAttemptsApp.Respond.Controller
      #controller.respond(id)

  App.addInitializer ->
    new LessonAttemptsApp.Router
      controller: API

  App.vent.on "edit:lesson_attempt:clicked", (lesson_attempt) ->
    App.navigate "lesson_attempts/#{lesson_attempt.attributes.id}/review"
    API.review lesson_attempt.get('id')

  App.vent.on "respond:question_attempt:clicked", (question_attempt) ->
    API.reviewQuestionAttempt question_attempt
