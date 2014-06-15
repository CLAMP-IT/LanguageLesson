@LanguageLesson.module "Entities",(Entities, App, Backbone, Marionette, $, _) ->
  class Entities.LessonAttempt extends Entities.Model
    urlRoot: -> Routes.lesson_attempts_path()

  API =
    getLessonAttemptEntity: (id, cb) ->
      lessonAttempt = new Entities.LessonAttempt
        id: id
          
      lessonAttempt.fetch
        reset: true
        success: (model, response) ->
          cb lesson

      lessonAttempt

    newLessonAttemptEntity: (lesson_id, user_id, cb) ->
      lessonAttempt = new Entities.LessonAttempt
        lesson_id: lesson_id
        user_id: user_id

      # lessonAttempt.save()

      App.request "lesson:entity", lesson_id, (lesson) =>
        lessonAttempt.lesson = lesson

        cb lessonAttempt

  App.reqres.setHandler "lesson_attempt:entity", (id, cb) ->
    API.getLessonAttemptEntity id, cb

  App.reqres.setHandler "new:lesson_attempt:entity", (lesson_id, user_id, cb) ->
    API.newLessonAttemptEntity lesson_id, user_id, cb

