@LanguageLesson.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Activity extends Entities.AssociatedModel
    urlRoot: Routes.activities_path()
    paramRoot: 'activity'

  API =
    setCurrentActivity: (currentActivity) ->
      App.currentActivity = new Entities.Activity currentActivity

      App.currentActivity

    getCurrentActivity: ->
      App.currentActivity

  App.reqres.setHandler "get:current:activity", ->
    API.getCurrentActivity()

  App.reqres.setHandler "set:current:activity", (currentActivity) ->
    API.setCurrentActivity currentActivity
