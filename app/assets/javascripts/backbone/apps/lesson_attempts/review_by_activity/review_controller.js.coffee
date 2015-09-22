@LanguageLesson.module "LessonAttemptsApp.ReviewByActivity", (ReviewByActivity, App, Backbone, Marionette, $, _) ->
  class ReviewByActivity.Controller extends App.Controllers.Application
    initialize: (options) ->
      @options = options

      App.reqres.setHandler 'lesson_attempt:review_by_activity:get_questions', =>
        return @questions_collection

      App.vent.on 'lesson_attempt:review_by_activity:show_question_attempt', (question_attempt) =>
        @question_attempt_layout = new ReviewByActivity.QuestionAttemptLayout
          model: question_attempt

        @layout.matrixRegion.show @question_attempt_layout

        @question_attempt_layout.showQuestionAttempt(question_attempt)

    review: (activity_id) ->
      RecorderControls.initialize()

      RecorderControls.recorder.addEventListener 'dataAvailable', @handleRecording

      $.getJSON(Routes.by_activity_lesson_attempts_path(activity_id),
        format: 'json').done (data) =>
          @lesson = App.request 'lesson:entity:from_data', data.lesson

          @users_collection = App.request 'user:entities:from_array', data.users

          @questions_collection = App.request 'question:entities:from_array', data.questions

          @layout = new ReviewByActivity.Layout

          @layout.on "show", =>
            @infoView = new ReviewByActivity.LessonInfo
              model: @lesson

            @userMatrix = new ReviewByActivity.UserMatrix
              collection: @users_collection

            @layout.infoRegion.show @infoView
            @layout.matrixRegion.show @userMatrix

          App.mainRegion.show @layout

    handleRecording: (e) =>
      @currentRecording = App.request "create:recording:entity"
      @currentRecording.set('blob', e.detail)

      audio = document.getElementById('response-recording-audio')
      audio.src = @currentRecording.getUrl()
