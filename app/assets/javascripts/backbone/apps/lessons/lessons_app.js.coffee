@LanguageLesson.module "LessonsApp", (LessonsApp, App, Backbone, Marionette, $, _) ->      
  class LessonsApp.Router extends Marionette.AppRouter
    appRoutes:
      "lessons/new" : "createLesson"
      "lessons/:id" : "showLesson"
      "lessons/:id/attempt" : "attemptLesson"
        
    API =
      showLesson: (id) ->
        LessonsApp.Show.Controller.showLesson(id)

      createLesson: ->
        LessonsApp.Create.Controller.createLesson()

      attemptLesson: ->
        LessonsApp.Attempt.Controller.attemptLesson()
                
    App.addInitializer ->
      new LessonsApp.Router
        controller: API
