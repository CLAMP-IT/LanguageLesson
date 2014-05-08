@LanguageLesson.module "LessonsApp.Show", (Show, App, Backbone, Marionette, $, _) ->
  class Show.LessonInfo extends App.Views.ItemView
    template: "lessons/show/templates/lesson_info"

  class Show.Layout extends App.Views.Layout
    template: "lessons/show/templates/show_layout"

    keys:
      'left': 'prev'
      'right': 'next'

    regions:
      infoRegion: "#info-region"
      elementsRegion: "#elements-region"
      
    prev: ->
      App.trigger('lesson:previous_element', @model)
 
    next: ->
      App.trigger('lesson:next_element', @model)
                
