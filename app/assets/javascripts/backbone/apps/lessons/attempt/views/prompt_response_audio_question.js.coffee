//= require wavesurfer.js/src/wavesurfer.js
//= require wavesurfer.js/src/webaudio.js
//= require wavesurfer.js/src/webaudio.buffer.js
//= require wavesurfer.js/src/webaudio.media.js
//= require wavesurfer.js/src/drawer.js
//= require wavesurfer.js/src/drawer.canvas.js
//= require ./attempt.element
//= require s3upload

@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.PromptResponseAudioQuestionElement extends Attempt.Element
    counter: 0

    template: 'lessons/attempt/templates/_prompt_response_audio_question'

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
            console.log @question_attempt.attributes['recordings'][0].full_url
            @showRecording @question_attempt.attributes['recordings'][0].full_url

      if @model.get('recording.full_url')
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

        wavesurfer.load( @model.get('recording.full_url') )

        @$('.js-play-pause').click ->
          wavesurfer.playPause()

      RecorderControls.onRecordingInterval(1000, =>
        @counter += 1
        console.log @counter
      )


      return

    onDestroy: ->
      console.log 'closing'

    startRecording: ->
      RecorderControls.startRecording()
      $('.lesson_element').addClass('recording')

    stopRecording: ->
     # RecorderControls.recorder.addEventListener 'dataAvailable', (e) ->
     #   console.log 'data avaoil'

      # fileName = (new Date).toISOString() + '.' + e.detail.type.split('/')[1]
      # url = URL.createObjectURL(e.detail)
      # console.log e
      # audio = document.createElement('audio')
      # audio.controls = true
      # audio.src = url

      # link = document.createElement('a')
      # link.href = url
      # link.download = fileName
      # link.innerHTML = link.download

      # li = document.createElement('li')
      # li.appendChild link
      # li.appendChild audio

      # $('#recordings-list').append li

      # return
      RecorderControls.stopRecording()


      #RecorderControls.exportWAV((blob) =>
      #  console.log 'hello?2'
        # url = URL.createObjectURL(blob)

        # @showRecording url

        # form = new FormData()
        # form.append("recording[file]", blob, 'recording.wav')
        # form.append("[question_attempt][lesson_attempt_id]", @options['attempt'].attributes['id'])
        # form.append("[question_attempt][question_id]", @model.attributes['element_id'])
        # form.append("[question_attempt][user_id]", @options['user'].attributes['id'])

        # postUrl = Routes.add_lesson_attempt_question_attempts_path(@.options['attempt'].attributes['id'], format: 'json')

        # s3postInfo = $.ajax(Routes.backbone_signS3put_path(), data: {'s3_object_name': 'recordings', 's3_object_type': 'foo'})

        # oReq = new XMLHttpRequest()
        # oReq.open("POST", postUrl)
        # oReq.send(form)
        # return
      #)

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
      #li.appendChild(hf)
      $('#recordings-list').append li

pad = (number, length) ->
  str = "" + number
  str = "0" + str  while str.length < length
  str

formatTime = (time) ->
  min = parseInt(time / 6000)
  sec = parseInt(time / 100) - (min * 60)
  hundredths = pad(time - (sec * 100) - (min * 6000), 2)
  ((if min > 0 then pad(min, 2) else "00")) + ":" + pad(sec, 2) + ":" + hundredths
