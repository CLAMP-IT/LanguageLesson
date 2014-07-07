@LanguageLesson.module "LessonAttemptsApp.Review", (Review, App, Backbone, Marionette, $, _) ->
  class Review.QuestionAttemptResponse extends App.Views.ItemView
    template: "lesson_attempts/review/templates/_question_attempt_response"
    className: 'responseBox'

    initialize: (options) ->
      @recording = null
      _.bindAll(@, 'hasRecording', 'getRecording', 'playRecording', 'enablePlayRemoveButtons', 'disablePlayRemoveButtons')
      
    events:
      "click .js-record-toggle" : "toggleRecording"
      "click .js-record-play"   : "playRecording"
      "click .js-record-remove" : "removeRecording"

    triggers:
      "mouseenter .responseForm": "question_attempt_response:selected"

    modelEvents:
      "updated" : "render"

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
      @$("#response-recording-audio").attr('src', null)
      @disablePlayRemoveButtons()
      return
      
    enablePlayRemoveButtons: ->
      @$('.js-record-play').prop('disabled', false)
      @$('.js-record-remove').prop('disabled', false)
      return
      
    disablePlayRemoveButtons: ->
      @$('.js-record-play').prop('disabled', true)
      @$('.js-record-remove').prop('disabled', true)
      return
      
    toggleRecording: (event) ->
      RecorderControls.toggleRecording()
      
      if RecorderControls.recording
        $(event.currentTarget).addClass('btn-danger')
        @disablePlayRemoveButtons()
      else
        $(event.currentTarget).removeClass('btn-danger')
        RecorderControls.exportWAV((blob) =>
          @recording_url = URL.createObjectURL(blob)
          console.log @recording_url
          #$("#response-recording-audio").src = @recording
          #$('#response-recording-audio').src = @recording_url
          @$('#response-recording-audio').attr('src', @recording_url)

          @enablePlayRemoveButtons()
          #@$('#play_button').click =>
          #  console.log $("#response-recording-audio").src
          #X  @$("#response-recording-audio").trigger('play')
          RecorderControls.clear()
        )
          
    onShow: ->

  class Review.QuestionAttemptResponses extends App.Views.CollectionView
    itemView: Review.QuestionAttemptResponse
    #tagName: "ul"

    modelEvents:
      "updated" : "render"

    #childEvents:
    #  "mouseenter": ->
    #    console.log 'mouseenter'
