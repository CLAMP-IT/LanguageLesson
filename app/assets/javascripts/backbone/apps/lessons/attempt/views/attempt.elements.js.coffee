@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.Elements extends App.Views.Layout
    currentView: 0

    template: "lessons/attempt/templates/elements_collection"

    regions:
      elements: '#elements'

    itemViewContainer: ->
      '#elements'

    initialize: (options) ->      
      _.bindAll @, 'previousView',
        'nextView',
        'onRender',
        'showElementView'
        
      LanguageLesson.on "lesson:previous_element", @previousView
        
      LanguageLesson.on "lesson:next_element", @nextView

      @options = options || {}

      return

    onRender: ->
      @showElementView()

    nextView: (element) ->
      if @currentView < (@model.elements.length - 1)
        $('.lesson_element').fadeOut 200, ( ->
          @currentView += 1
          @showElementView()
          $("#element_count").html("#{@currentView + 1} of #{@model.elements.length}")        
          return
        ).bind(@)
                                          
    previousView: (element) ->
      if @currentViezw > 0
        $('.lesson_element').fadeOut 200, ( ->
          @currentView -= 1
          @showElementView()
          $("#element_count").html("#{@currentView + 1} of #{@model.elements.length}")  
          return
        ).bind(@)

    showElementView: ->
      model = @model.elements.models[@currentView]

      # Homegrown prototypal behavior
      switch model.attributes.type
        when 'PromptedAudioQuestion'
          element = new Attempt.PromptedAudioQuestionElement
            model: @model.elements.models[@currentView]
        when 'ContentBlock'
           element = new Attempt.ContentBlockElement
            model: @model.elements.models[@currentView]

      #App.vent.on 'lesson:prevent_stepping_forward', (childView, model) ->
      #  console.log 'preventing 1'
      #  return
      
      @elements.show element


