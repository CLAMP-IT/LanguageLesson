@LanguageLesson.module "Entities",(Entities, App, Backbone, Marionette, $, _) ->
  class Entities.QuestionAttempt extends Entities.Model
    urlRoot: -> Routes.question_attempts_path()

  API =
    findQuestionAttemptEntity: (lesson_attempt_id, question_id, user_id, cb) ->
      questionAttempt = new Entities.QuestionAttempt

      questionAttempt.fetch
        url: Routes.find_question_attempt_by_lesson_attempt_question_and_user_path(lesson_attempt_id, question_id, user_id)
        #reset: true
        success: (model, response) ->
          cb questionAttempt
          
      questionAttempt   
      
  App.reqres.setHandler "find:question_attempt:entity", (lesson_attempt_id, question_id, user_id, cb) ->
    API.findQuestionAttemptEntity lesson_attempt_id, question_id, user_id, cb

