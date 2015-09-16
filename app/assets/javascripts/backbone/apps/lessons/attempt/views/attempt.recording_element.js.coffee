//= require ./attempt.element

@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.RecordingElement extends Attempt.Element
    events:
      'click .js-record-begin': 'startRecording'
      'click .js-record-end': 'stopRecording'
      'click .js-record-playback': 'playRecording'

    playRecording: () ->
      App.vent.trigger "lesson:play_recording"

    showRecording: (url) ->
      console.log "showing recording at #{url}"

    applyRecording: (recording) =>
      @question_attempt.set('recording', recording)
      console.log 'applied recording', @question_attempt
