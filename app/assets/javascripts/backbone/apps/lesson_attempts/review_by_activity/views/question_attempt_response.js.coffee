@LanguageLesson.module "LessonAttemptsApp.ReviewByActivity", (ReviewByActivity, App, Backbone, Marionette, $, _) ->
  class ReviewByActivity.QuestionAttemptResponse extends App.Views.ItemView
    template: "lesson_attempts/review_by_activity/templates/_question_attempt_response"

    className: 'responseBox'

    initialize: (options) ->
      @recording = null
      _.bindAll(@, 'hasRecording', 'getRecording', 'playRecording', 'showRecording', 'enablePlayButton', 'disablePlayButton')

    events:
      "click .js-record-toggle" : "toggleRecording"

      "click .js-record-play"   : "playRecording"

      "click .js-record-remove" : (e) ->
        @$('[data-toggle=tooltip]').tooltip('hide')
        @model.destroy()

      "change .note_field" : ->
        @model.set('note', @$('.note_field').val())

    triggers:
      "mouseenter .responseForm": "question_attempt_response:selected"
      "mouseleave .responseForm": "question_attempt_response:deselected"
      "click .js-play-region" : "question_attempt_response:play_region"

    onRender: ->
      @$('[data-toggle=tooltip]').tooltip(container: 'body')

      @showRecording() if @model.get('recording')

    modelEvents:
      "updated" : "render"

    acceptRecording: (recording_blob) =>
      recording = App.request "create:recording:entity"
      recording.set('blob', recording_blob)

      @model.set('recording', recording)

      @model.save(
        null
        success: =>
          console.log 'success'
          @showRecording()
      )

    showRecording: ->
      @$(".response-recording-audio").attr('src', @model.get('recording.full_url'))

      @enablePlayButton()

    hasRecording: ->
      return @$(".response-recording-audio").attr('src') != null

    getRecording: ->
      if @hasRecording
        return @$(".response-recording-audio").attr('src')
      else
        return null

    playRecording: ->
      @$(".response-recording-audio").trigger('play')
      return false

    enablePlayButton: ->
      @$('.js-record-play').prop('disabled', false)
      return

    disablePlayButton: ->
      @$('.js-record-play').prop('disabled', true)
      return

    highlight: =>
      @$('.btn, .note_field').addClass('transparent-rose')
      return

    dehighlight: =>
      @$('.btn, .note_field').removeClass('transparent-rose')
      return

    toggleRecording: (event)->
      RecorderControls.toggleRecording()

      if RecorderControls.recording
        RecorderControls.setRecordingAcceptor(@)
        $(event.currentTarget).addClass('btn-danger')
        @disablePlayButton()
      else
        $(event.currentTarget).removeClass('btn-danger')
        @enablePlayButton()

      return false
