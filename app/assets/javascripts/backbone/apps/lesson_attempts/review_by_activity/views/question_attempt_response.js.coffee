@LanguageLesson.module "LessonAttemptsApp.ReviewByActivity", (ReviewByActivity, App, Backbone, Marionette, $, _) ->
  class ReviewByActivity.QuestionAttemptResponse extends App.Views.ItemView
    template: "lesson_attempts/review_by_activity/templates/_question_attempt_response"

    className: 'responseBox'

    initialize: (options) ->
      @recording = null
      _.bindAll(@, 'hasRecording', 'getRecording', 'playRecording', 'showRecording', 'removeRecording', 'enablePlayButton', 'disablePlayButton')

    events:
      "click .js-record-toggle" : "toggleRecording"
      "click .js-record-play"   : "playRecording"
      "click .js-record-remove" : "removeRecording"
      "change .note_field" : ->
        @model.set('note', @$('.note_field').val())

    triggers:
      "mouseenter .responseForm": "question_attempt_response:selected"

    onShow: ->
      console.log 'onShow'

    onRender: ->
      @$('[data-toggle=tooltip]').tooltip(container: 'body')

      @showRecording() if @model.get('recording')

    onDestroy: ->
      App.trigger('question_attempt_response:closing', @model)

    modelEvents:
      "updated" : "render"

    showRecording: ->
      @$("#response-recording-audio").attr('src', @model.get('recording.url'))
      @enablePlayButton()

    hasRecording: ->
      return @$("#response-recording-audio").attr('src') != null

    getRecording: ->
      if @hasRecording
        return @$("#response-recording-audio").attr('src')
      else
        return null

    playRecording: ->
      @$("#response-recording-audio").trigger('play')
      return false

    removeRecording: ->
      @$('[data-toggle=tooltip]').tooltip('hide')
      @trigger("response:remove", @model)
      @model.destroy()
      @destroy()

    enablePlayButton: ->
      @$('.js-record-play').prop('disabled', false)
      return

    disablePlayButton: ->
      @$('.js-record-play').prop('disabled', true)
      return

    toggleRecording: (event)->
      RecorderControls.toggleRecording()

      if RecorderControls.recording
        $(event.currentTarget).addClass('btn-danger')
        @disablePlayButton()
      else
        $(event.currentTarget).removeClass('btn-danger')
        @enablePlayButton()

      return false

    onShow: ->
