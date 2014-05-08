@LanguageLesson.module "LessonsApp", (LessonsApp, App, Backbone, Marionette, $, _) ->      
  class LessonsApp.Router extends Marionette.AppRouter
    appRoutes:
      "lessons/:id" : "showLesson"
        
    API =
      showLesson: (id) ->
        LessonsApp.Show.Controller.showLesson(id)
        
    App.addInitializer ->
      new LessonsApp.Router
        controller: API
