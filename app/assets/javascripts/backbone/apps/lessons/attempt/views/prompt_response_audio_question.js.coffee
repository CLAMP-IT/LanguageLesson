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

