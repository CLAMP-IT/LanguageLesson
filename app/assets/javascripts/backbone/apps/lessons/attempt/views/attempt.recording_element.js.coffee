//= require ./attempt.element

@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.RecordingElement extends Attempt.Element
    events:
      'click .js-record-begin': 'startRecording'
      'click .js-record-end': 'stopRecording'
      'click .js-record-playback': 'playRecording'

    onShow: ->
      App.request "find:question_attempt:entity", @currentAttempt.get('id'), @model.get('element_id'), @currentUser.get('id'), (question_attempt) =>
        if question_attempt.get('id')
          @question_attempt = question_attempt

          App.vent.trigger "lesson:allow_stepping_forward"
          App.vent.trigger "lesson:set_current_recording", @question_attempt.get('recording')
          @showPlaybackButton()
        else
          @question_attempt = App.request "new:question_attempt:entity", @currentAttempt.get('id'), @model.get('element_id'), @currentUser.get('id')
          App.vent.trigger "lesson:prevent_stepping_forward"
          $('.next').prop('disabled', true)

      return

    startRecording: ->
      RecorderControls.startRecording()

      $('.lesson_element').addClass('recording')

    stopRecording: ->
      RecorderControls.stopRecording()

      RecorderControls.clear()

      $('.lesson_element').removeClass('recording')

      $('.next').prop('disabled', false)
      App.vent.trigger "lesson:allow_stepping_forward"

    showPlaybackButton: ->
      $('#playback-button').removeClass('hidden')

    playRecording: () ->
      App.vent.trigger "lesson:play_recording"

    showRecording: (url) ->
      console.log "showing recording at #{url}"

    applyRecording: (recording) =>
      @question_attempt.set('recording', recording)

      $.spin('true')
      @question_attempt.save(
        null
        success: (model, response) =>
          $.spin('false')
          @showPlaybackButton()
          $('#recording-success').removeClass('hidden')
        error: (model, response) =>
          $.spin('false')
          $('#recording-failure').removeClass('hidden')
      )

    saveAttempt: =>
      @question_attempt.save()

    onDestroy: ->
      console.log 'closing'
