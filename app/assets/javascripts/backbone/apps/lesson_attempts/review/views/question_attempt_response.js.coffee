@LanguageLesson.module "LessonAttemptsApp.Review", (Review, App, Backbone, Marionette, $, _) ->
  class Review.QuestionAttemptResponse extends App.Views.ItemView
    template: "lesson_attempts/review/templates/_question_attempt_response"
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
        console.log @model

    triggers:
      "mouseenter .responseForm": "question_attempt_response:selected"

    onShow: ->
      console.log 'onShow'

    onRender: ->
      console.log @model
      #@$('.note_field').val(@model.get('note')) if @model.get('note')
      @$('[data-toggle=tooltip]').tooltip(container: 'body')

      @showRecording() if @model.attributes['recording']

    onDestroy: ->
      console.log @
      App.trigger('question_attempt_response:closing', @model)

    modelEvents:
      "updated" : "render"

    showRecording: ->
      console.log "showing recording"
      console.log @model.get('recording')

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

    removeRecording: ->
      @$('[data-toggle=tooltip]').tooltip('hide')
      @trigger("response:remove", @model)
      @model.destroy()
      @destroy()
      #@$("#response-recording-audio").attr('src', null)
      #@disablePlayButton()
      #return

    enablePlayButton: ->
      @$('.js-record-play').prop('disabled', false)
      return

    disablePlayButton: ->
      @$('.js-record-play').prop('disabled', true)
      return

    toggleRecording: (event) ->
      RecorderControls.toggleRecording()

      if RecorderControls.recording
        $(event.currentTarget).addClass('btn-danger')
        @disablePlayButton()
      else
        $(event.currentTarget).removeClass('btn-danger')

        RecorderControls.exportWAV((blob) =>
          @recording_url = URL.createObjectURL(blob)

          recording = App.request "create:recording:entity"
          recording.set('blob', blob)
          recording.set('url', @recording_url)
          #console.log recording
          recording.save()
          @model.set('recording', recording)
          console.log @model

          @showRecording()
          #$("#response-recording-audio").src = @recording
          #$('#response-recording-audio').src = @recording_url
          #@$('#response-recording-audio').attr('src', @recording_url)

          #@enablePlayButton()
          #@$('#play_button').click =>
          #  console.log $("#response-recording-audio").src
          #X  @$("#response-recording-audio").trigger('play')
          RecorderControls.clear()
        )

    onShow: ->
