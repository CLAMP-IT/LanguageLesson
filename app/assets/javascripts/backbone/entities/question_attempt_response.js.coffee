@LanguageLesson.module "Entities",(Entities, App, Backbone, Marionette, $, _) ->
  class Entities.QuestionAttemptResponse extends Entities.AssociatedModel
    urlRoot: -> Routes.question_attempt_responses_path()

    paramRoot: 'question_attempt_response'

    rubyClass: 'QuestionAttemptResponse'

    relations: [
      {
        type: Backbone.One
        key: 'question_attempt'
        relatedModel: 'LanguageLesson.Entities.QuestionAttempt'
      },
      {
        type: Backbone.One
        key: 'recording'
        relatedModel: 'LanguageLesson.Entities.Recording'
      }
    ]

    defaults:
      recording: null

    initialize: ->
      @listenTo @, 'change:recording', (model) ->
        model.save()

      @listenTo @, 'change:note', (model) ->
        model.save()

    save: (attributes, options) ->
      recording = @get('recording')

      if recording
        recording.uploadRecording( =>
          Backbone.AssociatedModel.prototype.save.call(@, attributes, options)
        )
      else
        Backbone.AssociatedModel.prototype.save.call(@, attributes, options)

  class Entities.QuestionAttemptResponses extends Entities.Collection
    model: Entities.QuestionAttemptResponse

  API =
    createQuestionAttemptResponse: (question_attempt) ->
      new Entities.QuestionAttemptResponse
        question_attempt_id: question_attempt.id

  App.reqres.setHandler "create:question_attempt_response:entity", (question_attempt) ->
    API.createQuestionAttemptResponse question_attempt
