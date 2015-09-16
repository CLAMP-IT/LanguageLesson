//= require wavesurfer.js/src/wavesurfer.js
//= require wavesurfer.js/src/webaudio.js
//= require wavesurfer.js/src/webaudio.buffer.js
//= require wavesurfer.js/src/webaudio.media.js
//= require wavesurfer.js/src/drawer.js
//= require wavesurfer.js/src/drawer.canvas.js
//= require ./attempt.element
//= require ./attempt.recording_element

@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.PromptedAudioQuestionElement extends Attempt.RecordingElement
    template: 'lessons/attempt/templates/_prompted_audio_question'

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


      return
    onDestroy: ->
      console.log 'closing'

