@LanguageLesson.module "ActivitiesApp", (ActivitiesApp, App, Backbone, Marionette, $, _) ->
  class ActivitiesApp.Router extends Marionette.AppRouter
    appRoutes:
      "activities/:id/choose_doable" : "chooseDoable"

    API =
      chooseDoable: (id) ->
        controller = new ActivitiesApp.Choose.Controller
        controller.chooseDoable()

    App.addInitializer ->
      new ActivitiesApp.Router
        controller: API
