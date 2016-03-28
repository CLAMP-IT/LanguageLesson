//= require ./student_review.element

@LanguageLesson.module "LessonAttemptsApp.StudentReview", (StudentReview, App, Backbone, Marionette, $, _) ->
  class StudentReview.RecordingElement extends StudentReview.Element
    events:
      'click .js-record-playback': 'playRecording'

    onShow: ->
      App.request "find:question_attempt:entity", @currentAttempt.get('id'), @model.get('element_id'), @currentUser.get('id'), (question_attempt) =>
        if question_attempt.get('recording.full_url')
          @wavesurfer = Object.create(WaveSurfer)

          @wavesurfer.init
            container: '.response_wave'

          @wavesurfer.load( question_attempt.get('recording.full_url') )

          @$('.js-play').click =>
            @wavesurfer.play()

      return

    showPlaybackButton: ->
      $('#playback-button').removeClass('hidden')

    playRecording: () ->
      App.vent.trigger "lesson:play_recording"
