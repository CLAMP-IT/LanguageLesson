//= require wavesurfer.js/src/wavesurfer.js
//= require wavesurfer.js/src/webaudio.js
//= require wavesurfer.js/src/webaudio.buffer.js
//= require wavesurfer.js/src/webaudio.media.js
//= require wavesurfer.js/src/drawer.js
//= require wavesurfer.js/src/drawer.canvas.js
//= require wavesurfer.js/src/wavesurfer.timeline.js
//= require ./attempt.element

@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.PromptedAudioQuestionElement extends Attempt.Element
    template: 'lessons/attempt/templates/_prompted_audio_question'

    events:
      'click .js-record-begin': 'startRecording'
      'click .js-record-end': 'stopRecording'
      
    startRecording: ->
      RecorderControls.startRecording()
      $('.lesson_element').addClass('recording')

    stopRecording: ->
      RecorderControls.stopRecording()
      $('.lesson_element').removeClass('recording')
      #$('.next').prop('disabled', false)
      #App.vent.trigger "lesson:allow_stepping_forward"
      
    onShow: ->
      #SimpleAudio.activate()
      App.vent.trigger "lesson:prevent_stepping_forward"

      $('.next').prop('disabled', true)

      wavesurfer = Object.create(WaveSurfer)

      wavesurfer.init
        container     : '#waveform'
        height: 60
        fillParent    : true
        markerColor   : 'rgba(0, 0, 0, 0.5)'
        frameMargin   : 0.1
        maxSecPerPx   : parseFloat(location.hash.substring(1))
        loadPercent   : true
        waveColor     : 'orange'
        progressColor : 'red'
        loadingColor  : 'purple'
        xcursorColor   : 'navy'
      
      wavesurfer.load( $(".simple-audio-player").data('src') )

      wavesurfer.on('selection-update', (selection) ->
        console.log selection
      )

      #RecorderControls.initialize()

    onClose: ->
      console.log 'closing'
