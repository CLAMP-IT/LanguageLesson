//= require_tree ./views

@LanguageLesson.module "ActivitiesApp.Choose", (Choose, App, Backbone, Marionette, $, _) ->
  class Choose.Controller extends App.Controllers.Application
    chooseDoable: (id) ->
      #@layout = @getLayoutView()
      console.log 'choosing'

      @layout = @getLayoutView()

      App.mainRegion.show @layout

    getLayoutView: ->
      new Choose.Layout
