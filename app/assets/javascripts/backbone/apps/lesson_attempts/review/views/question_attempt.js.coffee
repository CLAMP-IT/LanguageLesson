//= require wavesurfer.js/src/wavesurfer.js
//= require wavesurfer.js/src/webaudio.js
//= require wavesurfer.js/src/webaudio.buffer.js
//= require wavesurfer.js/src/webaudio.media.js
//= require wavesurfer.js/src/drawer.js
//= require wavesurfer.js/src/drawer.canvas.js

@LanguageLesson.module "LessonAttemptsApp.Review", (Review, App, Backbone, Marionette, $, _) ->
  class Review.QuestionAttempt extends App.Views.ItemView
    template: "lesson_attempts/review/templates/question_attempt"
    #childViewContainer: '#responses'
    #childView: Review.QuestionAttemptResponse

    initialize: ->
      @wavesurfer = Object.create(WaveSurfer)
      
    onShow: ->
      if @model.attributes['recordings'][0]
        @showRecording @model.attributes['recordings'][0].url

    onClose: ->
      console.log 'Closing'
      console.log @model.get('responses').models
      for response in @model.get('responses').models
        console.log response.hasRecording()

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
      #console.log 'showing recording'
      #console.log @
      # li = document.createElement('li')
      # au = document.createElement('audio')
      # hf = document.createElement('a')

      # au.controls = true
      # au.className = 'fooch'
      # au.src = url
      # hf.href = url
      # hf.download = new Date().toISOString() + '.wav'
      # hf.innerHTML = hf.download
      # li.appendChild(au)
      # #li.appendChild(hf)
      # $('#recordings-list').append li

      @wavesurfer.init
        container     : '.response_wave'
        #fillParent    : true,
        #markerColor   : 'rgba(0, 0, 0, 0.5)',
        #frameMargin   : 0.1,
        #maxSecPerPx   : parseFloat(location.hash.substring(1)),
        #loadPercent   : true,
        #waveColor     : 'orange',
        #progressColor : 'red',
        #loadingColor  : 'purple',
        #xcursorColor   : 'navy',
        #waveColor: 'violet'

      #@wavesurfer.on('loading', (something) ->
      #  console.log something
      #)

      #@wavesurfer.on('ready', =>
      #  @wavesurfer.play()
      #)

      @wavesurfer.load( url )

      #@wavesurfer.on 'selection-update', (selection) =>
      #  console.log $('.response_wave:active').length

      $('.response_wave').mouseup (eventData) =>
        selection = @wavesurfer.getSelection()

        new_response = App.request "create:question_attempt_response:entity", (@model) 
        new_response.set('mark_start', selection.startPosition)
        new_response.set('mark_end', selection.endPosition)
        
        @model.get('responses').push new_response
        
        #$('#responses').append $('<li>', text: selection.startPosition)
        @wavesurfer.clearRegions()
        newRegion = @wavesurfer.region(startPosition: selection.startPosition, endPosition: selection.endPosition)
        console.log newRegion
      #@wavesurfer.on 'region-created', (region) ->
      #  console.log region
