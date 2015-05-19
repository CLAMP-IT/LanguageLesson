//= require ./recording

@LanguageLesson.module "Entities",(Entities, App, Backbone, Marionette, $, _) ->
  class Entities.QuestionAttemptResponse extends Entities.AssociatedModel
    #urlRoot: -> Routes.question_attempt_responses_path()

    rubyClass: 'QuestionAttemptResponse'

    relations: [
      {
        type: Backbone.One
        key: 'recording'
        relatedModel: Entities.Recording
      }
    ]
    defaults:
      recording: null

    initialize: ->
      recording = @get('recording')

      @listenTo @, 'change:recording', (model) ->
        model.get('recording').saveRecording()

      @listenTo @, 'change:note', (model) ->
        model.save()
      #question_attempts.url = =>
      #  return "/lesson_attempts/#{@id}/question_attempts"


  class Entities.QuestionAttemptResponses extends Entities.Collection
    model: Entities.QuestionAttemptResponse

  API =
    createQuestionAttemptResponse: (question_attempt) ->
      response = new Entities.QuestionAttemptResponse
        question_attempt_id: question_attempt.get('id')

      response

  App.reqres.setHandler "create:question_attempt_response:entity", (question_attempt) ->
    API.createQuestionAttemptResponse question_attempt
