@LanguageLesson.module "Entities",(Entities, App, Backbone, Marionette, $, _) ->
  class Entities.QuestionAttempt extends Entities.AssociatedModel
    urlRoot: -> Routes.question_attempts_path()

    paramRoot: 'question_attempt'

    rubyClass: 'QuestionAttempt'

    relations: [
      {
        type: Backbone.One
        key: 'question'
        relatedModel: 'LanguageLesson.Entities.Question'
      },
      {
        type: Backbone.Many
        key: 'responses'
        collectionType: 'LanguageLesson.Entities.QuestionAttemptResponses'
      },
      {
        type: Backbone.One
        key: 'recording'
        relatedModel: 'LanguageLesson.Entities.Recording'
      }
    ]

    defaults:
      user: null
      lesson: null
      recording: null
      responses: []

    save: (attributes, options) ->
      @get('recording').uploadRecording( =>
        Backbone.AssociatedModel.prototype.save.call(@, attributes, options)
      )

    initialize: (options) ->
      options || (options = {})

      responses = @get('responses')

      responses.url = =>
        return "/question_attempts/#{@id}/question_attempt_responses"

      @listenTo responses, "add", (model) ->
        model.save(
          null
          success: (model, response) ->
            console.log 'success!'
            console.log model
            console.log response
          error: ->
            console.log 'err-or'
        )

      @listenTo responses, "destroy", (model) ->
        model.destroy()

      @listenTo responses, "change:", (model) ->
        #console.log model
        #model.save()


  class Entities.QuestionAttempts extends Entities.Collection
    model: Entities.QuestionAttempt

  API =
    findQuestionAttemptEntity: (lesson_attempt_id, question_id, user_id, cb) ->
      questionAttempt = new Entities.QuestionAttempt

      questionAttempt.fetch
        url: Routes.find_question_attempt_by_lesson_attempt_question_and_user_path(lesson_attempt_id, question_id, user_id)

        success: (model, response) ->
          cb questionAttempt

      questionAttempt

    newQuestionAttemptEntity: (lesson_attempt_id, question_id, user_id) ->
      new Entities.QuestionAttempt
        lesson_attempt_id: lesson_attempt_id
        question_id: question_id
        user_id: user_id
        recording: new Entities.Recording
          recordable_type: 'QuestionAttempt'

  App.reqres.setHandler "find:question_attempt:entity", (lesson_attempt_id, question_id, user_id, cb) ->
    API.findQuestionAttemptEntity lesson_attempt_id, question_id, user_id, cb

  App.reqres.setHandler "new:question_attempt:entity", (lesson_attempt_id, question_id, user_id) ->
    API.newQuestionAttemptEntity lesson_attempt_id, question_id, user_id
