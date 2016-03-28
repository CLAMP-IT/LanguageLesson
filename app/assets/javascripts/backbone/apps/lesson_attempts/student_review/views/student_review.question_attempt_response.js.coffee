@LanguageLesson.module "LessonAttemptsApp.StudentReview", (StudentReview, App, Backbone, Marionette, $, _) ->
  class StudentReview.QuestionAttemptResponse extends App.Views.ItemView
    template: "lesson_attempts/student_review/templates/_question_attempt_response"

    className: 'responseBox'

    events:
      "click .js-response-play"   : "playRecording"

    onRender: ->
      if @model.get('recording')
        @$('[data-toggle=tooltip]').tooltip(container: 'body')

        @$(".response-recording-audio").attr('src', @model.get('recording.full_url'))

    playRecording: ->
      @$(".response-recording-audio").trigger('play')
      return false

    triggers:
      "mouseenter .responseBox": "question_attempt_response:selected"
      "mouseleave .responseBox": "question_attempt_response:deselected"

    highlight: =>
      @$('.btn, .note_field').addClass('transparent-rose')
      return

    dehighlight: =>
      @$('.btn, .note_field').removeClass('transparent-rose')
      return
