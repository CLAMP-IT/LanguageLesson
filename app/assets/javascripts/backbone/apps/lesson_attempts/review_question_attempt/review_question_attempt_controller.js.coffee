//= require recorder_controls

@LanguageLesson.module "LessonAttemptsApp.ReviewQuestionAttempt", (ReviewQuestionAttempt, App, Backbone, Marionette, $, _) ->
  class ReviewQuestionAttempt.Controller extends App.Controllers.Application
    review: (question_attempt) ->
      console.log question_attempt
      @respondView = @getRespondView question_attempt
      
      #  @layout.on "show", =>
      #    @showAttemptInfo lesson_attempt
      #    @showQuestionAttemptList lesson_attempt
                      
      #  App.mainRegion.show @layout
      App.dialogRegion.show @respondView

    getRespondView: (question_attempt) ->
      new ReviewQuestionAttempt.Respond
        region: App.dialogRegion
        model: question_attempt
