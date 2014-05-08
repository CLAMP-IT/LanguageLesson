@LanguageLesson.module "LessonsApp.Show", (Show, App, Backbone, Marionette, $, _) ->
  class Show.Element extends App.Views.ItemView
    template: "lessons/show/templates/_bare_element"
    
    tagName: 'div'

    events:
      'click .prev': 'prev'
      'click .next': 'next'    

    prev: ->
      App.trigger('lesson:previous_element', @model)
    next: ->
      App.trigger('lesson:next_element', @model)
