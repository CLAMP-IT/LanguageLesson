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

    onShow: ->
      $("#element_count").html("#{@currentView + 1} of #{@model.get('lesson_elements').length}")        
    
    onRender: ->
      @showElementView()

    nextView: (element) ->
      if @currentView < (@model.get('lesson_elements').length - 1)
        $('.lesson_element').fadeOut 200, ( ->
          @currentView += 1
          @showElementView()
          $("#element_count").html("#{@currentView + 1} of #{@model.get('lesson_elements').length}")        
          return
        ).bind(@)
                                          
    previousView: (element) ->
      if @currentView > 0
        $('.lesson_element').fadeOut 200, ( ->
          @currentView -= 1
          @showElementView()
          $("#element_count").html("#{@currentView + 1} of #{@model.get('lesson_elements').length}")  
          return
        ).bind(@)

    showElementView: ->
      console.log @model
      model = @model.get('lesson_elements').models[@currentView]

      # Homegrown polymorphic behavior
      switch model.attributes.type
        when 'PromptedAudioQuestion'
          element = new Attempt.PromptedAudioQuestionElement
            model: @model.get('lesson_elements').models[@currentView]
            lesson: @model
            attempt: @options['attempt']
            user: @options['user']
        when 'ContentBlock'
           element = new Attempt.ContentBlockElement
            model: @model.get('lesson_elements').models[@currentView]
            lesson: @model
            attempt: @options['attempt']
            user: @options['user']
            
      @elements.show element
