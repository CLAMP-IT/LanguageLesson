//= require wavesurfer.js/src/wavesurfer.js
//= require wavesurfer.js/src/webaudio.js
//= require wavesurfer.js/src/webaudio.buffer.js
//= require wavesurfer.js/src/webaudio.media.js
//= require wavesurfer.js/src/drawer.js
//= require wavesurfer.js/src/drawer.canvas.js
//= require ./attempt.element

@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.PromptedAudioQuestionElement extends Attempt.Element
    template: 'lessons/attempt/templates/_prompted_audio_question'

    events:
      'click .js-record-begin': 'startRecording'
      'click .js-record-end': 'stopRecording'

    onShow: ->
      App.request "find:question_attempt:entity",
        @options['attempt'].attributes['id'],
        @model.attributes['element_id'],
        @options['user'].attributes['id'], (question_attempt) =>
          @question_attempt = question_attempt

          unless question_attempt.attributes['id']
            App.vent.trigger "lesson:prevent_stepping_forward"
            $('.next').prop('disabled', true)
          else
            App.vent.trigger "lesson:allow_stepping_forward"
            console.log @question_attempt.attributes['recordings'][0].url
            @showRecording @question_attempt.attributes['recordings'][0].url

      if @model.get('recording.url')
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

        wavesurfer.load( @model.get('recording.url') )

        @$('.js-play-pause').click ->
          wavesurfer.playPause()

      return
    onDestroy: ->
      console.log 'closing'

    startRecording: ->
      RecorderControls.startRecording()
      $('.lesson_element').addClass('recording')

    stopRecording: ->
      RecorderControls.recorder.addEventListener 'dataAvailable', (e) =>
        $.getJSON Routes.backbone_signS3put_path(format: 'json'), (data) ->
          form = new FormData()
          for index, value of data.signed_post
            form.append(index, value)

          form.append("file", e.detail, 'recording.ogg')

          $.ajax
            url: data.url
            type: "POST"
            data: form
            processData: false
            contentType: false
            success: (response) ->
              console.log $(response).find("Key").text()

      RecorderControls.stopRecording()

      RecorderControls.clear()

      $('.lesson_element').removeClass('recording')
      $('.next').prop('disabled', false)
      App.vent.trigger "lesson:allow_stepping_forward"

    showRecording: (url) ->
      console.log 'showing recording'
      li = document.createElement('li')
      au = document.createElement('audio')
      hf = document.createElement('a')

      au.controls = true
      au.src = url
      hf.href = url
      hf.download = new Date().toISOString() + '.wav'
      hf.innerHTML = hf.download
      li.appendChild(au)
      $('#recordings-list').append li
