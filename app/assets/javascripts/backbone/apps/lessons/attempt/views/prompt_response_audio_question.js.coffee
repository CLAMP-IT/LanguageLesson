//= require wavesurfer.js/src/wavesurfer.js
//= require wavesurfer.js/src/webaudio.js
//= require wavesurfer.js/src/webaudio.buffer.js
//= require wavesurfer.js/src/webaudio.media.js
//= require wavesurfer.js/src/drawer.js
//= require wavesurfer.js/src/drawer.canvas.js
//= require ./attempt.element
//= require s3upload
//= require ./attempt.recording_element

@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.PromptResponseAudioQuestionElement extends Attempt.RecordingElement
    counter: 0

    template: 'lessons/attempt/templates/_prompt_response_audio_question'

    onShow: ->
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


      RecorderControls.onRecordingInterval(1000, =>
        @counter += 1
        console.log @counter
      )


      return

    onDestroy: ->
      console.log 'closing'

pad = (number, length) ->
  str = "" + number
  str = "0" + str  while str.length < length
  str

formatTime = (time) ->
  min = parseInt(time / 6000)
  sec = parseInt(time / 100) - (min * 60)
  hundredths = pad(time - (sec * 100) - (min * 6000), 2)
  ((if min > 0 then pad(min, 2) else "00")) + ":" + pad(sec, 2) + ":" + hundredths
