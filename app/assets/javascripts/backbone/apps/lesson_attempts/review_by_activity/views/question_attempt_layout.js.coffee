//= require wavesurfer.js/src/wavesurfer.js
//= require wavesurfer.js/src/webaudio.js
//= require wavesurfer.js/src/webaudio.buffer.js
//= require wavesurfer.js/src/webaudio.media.js
//= require wavesurfer.js/src/drawer.js
//= require wavesurfer.js/src/drawer.canvas.js

@LanguageLesson.module "LessonAttemptsApp.ReviewByActivity", (ReviewByActivity, App, Backbone, Marionette, $, _) ->
  class ReviewByActivity.QuestionAttemptLayout extends App.Views.Layout
    template: "lesson_attempts/review_by_activity/templates/question_attempt_layout"

    regions:
      questionAttemptRegion: "#question-attempt-region"
      responsesRegion: "#responses-region"

    showQuestionAttempt: (question_attempt) ->
      @question_attempt_view = new ReviewByActivity.QuestionAttempt
        model: question_attempt

      @questionAttemptRegion.show @question_attempt_view

      @responses_view = new ReviewByActivity.QuestionAttemptResponses
        collection: question_attempt.get('responses')

      @listenTo @responses_view, "childview:question_attempt_response:selected", (iv, args) ->
        @question_attempt_view.activateRegion args.model

      @responsesRegion.show @responses_view
