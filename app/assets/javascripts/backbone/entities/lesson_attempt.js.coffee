//= require ./user
//= require ./lesson
//= require ./question_attempt

@LanguageLesson.module "Entities",(Entities, App, Backbone, Marionette, $, _) ->
  class Entities.LessonAttempt extends Entities.AssociatedModel
    urlRoot: -> Routes.lesson_attempts_path()

    rubyClass: 'LessonAttempt'

    initialize: ->
      @get('question_attempts').url = ->
        return "/lesson_attempt/#{@id}/question_attempts"

    relations: [
      {
        type: Backbone.One
        key: 'user'
        relatedModel: Entities.User
      },
      {
        type: Backbone.One
        key: 'lesson'
        relatedModel: Entities.Lesson
      },
      {
        type: Backbone.One
        key: 'question'
        relatedModel: Entities.Question
      },
      {
        type: Backbone.Many
        key: 'question_attempts'
        collectionType: Entities.QuestionAttempts
      }
    ]
    defaults:
      user: null
      lesson: null
      question_attempts: []
      # 
  class Entities.LessonAttemptsCollection extends Entities.Collection
    model: Entities.LessonAttempt
    url: -> Routes.lesson_attempts_path()

  API =
    getLessonAttemptEntity: (id, cb) ->
      lessonAttempt = new Entities.LessonAttempt
        id: id
          
      lessonAttempt.fetch
        reset: true
        success: (model, response) ->
          cb lessonAttempt

      lessonAttempt

    getLessonAttemptEntities: (cb) ->
      lesson_attempts = new Entities.LessonAttemptsCollection

      lesson_attempts.fetch
        success: ->
          cb lesson_attempts
          
    newLessonAttemptEntity: (lesson, user, cb) ->
      lessonAttempt = new Entities.LessonAttempt
        lesson: lesson
        user: user

      lessonAttempt.save()

      cb lessonAttempt

  App.reqres.setHandler "lesson_attempt:entity", (id, cb) ->
    API.getLessonAttemptEntity id, cb
  
  App.reqres.setHandler "lesson_attempt:entities", (cb) ->
    API.getLessonAttemptEntities cb

  App.reqres.setHandler "new:lesson_attempt:entity", (lesson, user, cb) ->
    API.newLessonAttemptEntity lesson, user, cb

