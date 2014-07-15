//= require recorder_controls

@LanguageLesson.module "LessonAttemptsApp.Review", (Review, App, Backbone, Marionette, $, _) ->
  class Review.Controller extends App.Controllers.Application
    initialize: (options) ->
      RecorderControls.initialize()
      
    review: (lesson_attempt_id) ->
      App.request "lesson_attempt:entity", lesson_attempt_id, (lesson_attempt) =>
        console.log lesson_attempt

        @layout = @getLayoutView lesson_attempt

        @layout.on "show", =>
          @showAttemptInfo lesson_attempt
          @showQuestionAttemptList lesson_attempt
          #@showQuestionAttemptLayout()

        App.mainRegion.show @layout

    showQuestionAttemptList: (lesson_attempt) ->
      questionAttemptsView = @getQuestionAttemptsView lesson_attempt
      @layout.questionAttemptsRegion.show questionAttemptsView
                
    showAttemptInfo: (lesson_attempt) ->
      infoView = @getInfoView(lesson_attempt)
      @layout.infoRegion.show infoView                   

    showQuestionAttemptLayout: ->
      @question_attempt_layout = new Review.QuestionAttemptLayout
      @layout.questionAttemptLayoutRegion.show @question_attempt_layout
                                        
    getLayoutView: (lesson_attempt) ->
      new Review.Layout

    getInfoView: (lesson_attempt) ->
      new Review.LessonAttemptInfo
        model: lesson_attempt

    getQuestionAttemptsView: (lesson_attempt) ->
      questionAttemptsView = new Review.QuestionAttempts
        collection: lesson_attempt.get('question_attempts')

      @listenTo questionAttemptsView, "childview:respond:question_attempt:clicked", (iv, args) ->
        question_attempt = args.model

        @question_attempt_layout = new Review.QuestionAttemptLayout
          model: question_attempt
          #collection: question_attempt.get('responses')
        @layout.questionAttemptLayoutRegion.show @question_attempt_layout  
        #@layout.questionAttemptLayoutRegion.show view
        @question_attempt_layout.showQuestionAttempt(args.model)
        
      questionAttemptsView
