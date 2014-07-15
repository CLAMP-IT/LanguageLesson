//= require wavesurfer.js/src/wavesurfer.js
//= require wavesurfer.js/src/webaudio.js
//= require wavesurfer.js/src/webaudio.buffer.js
//= require wavesurfer.js/src/webaudio.media.js
//= require wavesurfer.js/src/drawer.js
//= require wavesurfer.js/src/drawer.canvas.js

//= require ./show.element

@LanguageLesson.module "LessonsApp.Show", (Show, App, Backbone, Marionette, $, _) ->
  class Show.PromptedAudioQuestionElement extends Show.Element
    template: 'lessons/show/templates/_prompted_audio_question'
    
    onShow: ->
      #SimpleAudio.activate()

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

      #wavesurfer.mark
      #  id: 99
      #  percentage: 0.5322834525521346
      #  position: 1.5297336126138814
                  
      wavesurfer.on('ready', ->
        timeline = Object.create(WaveSurfer.Timeline)

        timeline.init
          wavesurfer: wavesurfer,
          container: "#wave-timeline"
      )

      RecorderControls.initialize()
      
