@LanguageLesson.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Lesson extends Entities.AssociatedModel
    urlRoot: -> Routes.lessons_path()

    rubyClass: 'Lesson'

    relations: [
      {
        type: Backbone.Many
        key: 'lesson_elements'
        collectionType: 'LanguageLesson.Entities.LessonElements'
      }
    ]
    defaults:
      lesson_elements: []

  class Entities.LessonsCollection extends Entities.Collection
    model: Entities.Lesson
    url: -> Routes.lessons_path()

  API =
     getLessonEntity: (id, cb) ->
       lesson = new Entities.Lesson
         id: id
       lesson.fetch
         reset: true
         success: (model, response) ->
           cb lesson
       lesson
        
  App.reqres.setHandler "lesson:entity", (id, cb) ->
    API.getLessonEntity id, cb
