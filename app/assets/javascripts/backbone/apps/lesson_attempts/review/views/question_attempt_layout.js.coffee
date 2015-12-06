@LanguageLesson.module "LessonAttemptsApp.Review", (Review, App, Backbone, Marionette, $, _) ->
  class Review.QuestionAttemptLayout extends App.Views.Layout
    template: "lesson_attempts/review/templates/question_attempt_layout"

    regions:
      questionAttemptRegion: "#question-attempt-region"
      responsesRegion: "#responses-region"

    #onDestroy: ->
      #console.log @
      #console.log @question_attempt_view#.question_attempt_responses#.get('responses').models
      #for response in @model.get('responses').models
      #  console.log response.hasRecording()

    showQuestionAttempt: (question_attempt) ->
      @question_attempt_view = new Review.QuestionAttempt
        model: question_attempt

      @questionAttemptRegion.show @question_attempt_view

      @responses_view = new Review.QuestionAttemptResponses
        collection: question_attempt.get('responses')

      @listenTo @responses_view, "childview:question_attempt_response:selected", (iv, args) ->
        @question_attempt_view.activateRegion args.model

      @responsesRegion.show @responses_view
