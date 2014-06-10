//= require jquery.ui.draggable

@LanguageLesson.module "LessonsApp.Create", (Create, App, Backbone, Marionette, $, _) ->
  class Create.PaletteView extends App.Views.ItemView
    template: "lessons/create/templates/create_palette"

    onShow: ->
      $('.palette-item').draggable()
