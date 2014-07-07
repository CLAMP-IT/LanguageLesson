@LanguageLesson.module "Entities",(Entities, App, Backbone, Marionette, $, _) ->
  class Entities.QuestionAttemptResponse extends Entities.AssociatedModel
    urlRoot: -> Routes.question_attempt_responses_path()

  class Entities.QuestionAttemptResponses extends Entities.Collection
    model: Entities.QuestionAttemptResponse

  API =
    createQuestionAttemptResponse: (question_attempt) ->
      response = new Entities.QuestionAttemptResponse
        question_attempt_id: question_attempt.get('id')
      
      response  
  
  App.reqres.setHandler "create:question_attempt_response:entity", (question_attempt) ->
    API.createQuestionAttemptResponse question_attempt

