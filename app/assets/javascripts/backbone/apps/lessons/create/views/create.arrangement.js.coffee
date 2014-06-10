//= require jquery.ui.droppable

@LanguageLesson.module "LessonsApp.Create", (Create, App, Backbone, Marionette, $, _) ->
  class Create.ArrangementView extends App.Views.ItemView
    template: "lessons/create/templates/create_arrangement"

    onShow: ->
      $('#arrangement-region').droppable
        drop: (event, ui) ->
          console.log event
          console.log ui
          ui.draggable.fadeOut()
          ui.draggable.fadeIn()
          App.trigger('lesson:create:new_element', @model)
          console.log App
