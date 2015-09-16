@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.LessonInfo extends App.Views.ItemView
    template: "lessons/attempt/templates/lesson_info"

  class Attempt.Layout extends App.Views.Layout
    template: "lessons/attempt/templates/attempt_layout"

    initialize: (options) ->
      @currentUser = options.currentUser
      @currentAttempt = options.currentAttempt

      App.vent.on 'lesson:prevent_stepping_forward', =>
        console.log 'preventing in the layout view'
        @preventSteppingForward()
        return

      App.vent.on 'lesson:allow_stepping_forward', =>
        console.log 'allowing in the layout view'
        @allowSteppingForward()
        return  
  
    # Begin by allowing movement forward but not back
    stepForward: true
    stepBackward: true
    
    keys:
      'left': 'prev'
      'right': 'next'

    events:
      'click .prev': 'prev'
      'click .next': 'next'

    regions:
      infoRegion: "#info-region"
      elementsRegion: "#elements-region"

    preventSteppingForward: () ->
      @stepForward = false

    allowSteppingForward: ->
      @stepForward = true

    preventSteppingBackward: () ->
      @stepBackward = false

    allowSteppingBackward: ->
      @stepBackward = true        

    next: ->
      if @stepForward
        App.trigger('lesson:next_element', @model)

    prev: ->
      if @stepBackward
        App.trigger('lesson:previous_element', @model)
