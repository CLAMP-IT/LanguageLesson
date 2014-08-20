//= require wavesurfer.js/src/wavesurfer.js
//= require wavesurfer.js/src/webaudio.js
//= require wavesurfer.js/src/webaudio.buffer.js
//= require wavesurfer.js/src/webaudio.media.js
//= require wavesurfer.js/src/drawer.js
//= require wavesurfer.js/src/drawer.canvas.js

@LanguageLesson.module "LessonAttemptsApp.Review", (Review, App, Backbone, Marionette, $, _) ->
  class Review.QuestionAttempt extends App.Views.ItemView
    template: "lesson_attempts/review/templates/question_attempt"

    initialize: ->
      @wavesurfer = Object.create(WaveSurfer)
      
    onShow: ->
      if @model.attributes['recordings'][0]
        @showRecording @model.attributes['recordings'][0].url
      
    #onDestroy: ->
    onBeforeDestroy: ->
      console.log 'question attempt closing'
      @model.set('responded', 't')
      console.log @model
      @model.save({'responded': 't'})
      #  null,
      #  success: (model, response) ->
      #    console.log('success')
      #  error: ->
      #    console.log('error')
      #)
    #onRender: ->
      #console.log 'onRender'

    activateRegion: (question_attempt_response) ->
      @wavesurfer.clearRegions()
      @wavesurfer.clearMarks()
      @wavesurfer.region(
        startPosition: question_attempt_response.get('mark_start'),
        endPosition:question_attempt_response.get('mark_end')
      )
                
    showRecording: (url) ->
      @wavesurfer.init
        container     : '.response_wave'

      @wavesurfer.load( url )

      @$('.js-play-pause').click =>
        @wavesurfer.playPause()

      $('.response_wave').mouseup (eventData) =>
        selection = @wavesurfer.getSelection()

        new_response = App.request "create:question_attempt_response:entity", (@model) 
        new_response.set('mark_start', selection.startPosition)
        new_response.set('mark_end', selection.endPosition)
        
        @model.get('responses').push new_response
        
        @wavesurfer.clearRegions()
        newRegion = @wavesurfer.region(startPosition: selection.startPosition, endPosition: selection.endPosition)

