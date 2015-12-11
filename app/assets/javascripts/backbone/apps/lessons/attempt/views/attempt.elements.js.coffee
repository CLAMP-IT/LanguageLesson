@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.Elements extends App.Views.Layout
    currentView: 0

    currentElement: null

    template: "lessons/attempt/templates/elements_collection"

    regions:
      elements: '#elements'

    itemViewContainer: ->
      '#elements'

    initialize: (options) ->
      @currentUser = options.currentUser

      @currentAttempt = options.currentAttempt

      _.bindAll @, 'previousView',
        'nextView',
        'onRender',
        'showElementView'

      LanguageLesson.on "lesson:previous_element", @previousView

      LanguageLesson.on "lesson:next_element", @nextView

      @options = options || {}

      @model.get('lesson_elements').at(0).set('first', true)
      @model.get('lesson_elements').at(@model.get('lesson_elements').length - 1).set('last', true)

      return

    onShow: ->
      $("#element_count").html("#{@currentView + 1} of #{@model.get('lesson_elements').length}")

    onRender: ->
      @showElementView()

    nextView: ->
      if @currentView < (@model.get('lesson_elements').length - 1)
        $('.lesson_element').fadeOut 200, ( ->
          @currentView += 1
          @showElementView()
          $("#element_count").html("#{@currentView + 1} of #{@model.get('lesson_elements').length}")
          return
        ).bind(@)

      return

    previousView: ->
      if @currentView > 0
        $('.lesson_element').fadeOut 200, ( ->
          @currentView -= 1
          @showElementView()
          $("#element_count").html("#{@currentView + 1} of #{@model.get('lesson_elements').length}")
          return
        ).bind(@)

      return

    showElementView: ->
      model = @model.get('lesson_elements').models[@currentView]

      # Homegrown polymorphic behavior
      switch model.attributes.type
        when 'PromptedAudioQuestion'
          @currentElement = new Attempt.PromptedAudioQuestionElement
            model: @model.get('lesson_elements').models[@currentView]
            lesson: @model
            currentAttempt: @currentAttempt
            currentUser: @currentUser
        when 'PromptResponseAudioQuestion'
          @currentElement = new Attempt.PromptResponseAudioQuestionElement
            model: @model.get('lesson_elements').models[@currentView]
            lesson: @model
            currentAttempt: @currentAttempt
            currentUser: @currentUser
        when 'ContentBlock'
           @currentElement = new Attempt.ContentBlockElement
            model: @model.get('lesson_elements').models[@currentView]
            lesson: @model
            currentAttempt: @currentAttempt
            currentUser: @currentUser

      @elements.show @currentElement

    applyRecording: (recording) =>
      @currentElement.applyRecording(recording)
