@LanguageLesson.module "LessonsApp.Show", (Show, App, Backbone, Marionette, $, _) ->
  class Show.Elements extends App.Views.Layout
    currentView: 0

    template: "lessons/show/templates/elements_collection"

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
      console.log @model.elements
                                          
    previousView: (element) ->
      if @currentView > 0
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
          element = new Show.PromptedAudioQuestionElement
            model: @model.elements.models[@currentView]
        when 'ContentBlock'
           element = new Show.ContentBlockElement
            model: @model.elements.models[@currentView]
      @elements.show element


