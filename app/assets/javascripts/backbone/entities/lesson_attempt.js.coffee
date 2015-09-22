@LanguageLesson.module "Entities",(Entities, App, Backbone, Marionette, $, _) ->
  class Entities.LessonAttempt extends Entities.AssociatedModel
    urlRoot: -> Routes.lesson_attempts_path()

    paramRoot: 'lesson_attempt'

    rubyClass: 'LessonAttempt'

    relations: [
      {
        type: Backbone.One
        key: 'user'
        relatedModel: 'LanguageLesson.Entities.User'
      },
      {
        type: Backbone.One
        key: 'lesson'
        relatedModel: 'LanguageLesson.Entities.Lesson'
      },
      {
        type: Backbone.One
        key: 'activity'
        relatedModel: 'LanguageLesson.Entities.Activity'
      },
      {
        type: Backbone.Many
        key: 'question_attempts'
        collectionType: 'LanguageLesson.Entities.QuestionAttempts'
      }
    ]
    defaults:
      user: null
      lesson: null
      activity: null
      question_attempts: []

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

    getLessonAttemptEntities: (lesson_id, cb) ->
      lesson_attempts = new Entities.LessonAttemptsCollection

      lesson_attempts.fetch
        url: Routes.by_lesson_lesson_attempts_path(lesson_id)
        success: ->
          cb lesson_attempts

          lesson_attempts

    newLessonAttemptEntity: (lesson_id, user_id, activity_id) ->
      defer = $.Deferred()

      lessonAttempt = new Entities.LessonAttempt
        lesson_id: lesson_id
        user_id: user_id
        activity_id: activity_id

      lessonAttempt.save(
        null
        success: ->
          defer.resolve lessonAttempt

        error: (e) ->
          console.log 'Error: #{e}'
      )

      defer.promise()

  App.reqres.setHandler "lesson_attempt:entity", (id, cb) ->
    API.getLessonAttemptEntity id, cb

  App.reqres.setHandler "lesson_attempt:entities", (cb) ->
    API.getLessonAttemptEntities cb

  App.reqres.setHandler "lesson_attempt:entities:by_lesson_id", (lesson_id, cb) ->
    API.getLessonAttemptEntitiesByLessonId lesson_id, cb

  App.reqres.setHandler "new:lesson_attempt:entity", (lesson_id, user_id, activity_id) ->
    API.newLessonAttemptEntity lesson_id, user_id, activity_id
