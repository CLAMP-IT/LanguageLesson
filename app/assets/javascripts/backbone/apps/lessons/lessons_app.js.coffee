@LanguageLesson.module "LessonsApp", (LessonsApp, App, Backbone, Marionette, $, _) ->
  class LessonsApp.Router extends Marionette.AppRouter
    appRoutes:
      "lessons/new" : "createLesson"
      "lessons/:id" : "showLesson"
      "lessons/:id/attempt" : "attemptLesson"

    API =
      showLesson: (id) ->
        controller = new LessonsApp.Show.Controller
        controller.showLesson(id)

      createLesson: ->
        LessonsApp.Create.Controller.createLesson()

      attemptLesson: (id) ->
        controller = new LessonsApp.Attempt.Controller
        controller.attemptLesson(id)

    App.addInitializer ->
      new LessonsApp.Router
        controller: API
