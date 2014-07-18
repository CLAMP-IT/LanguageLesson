//= require ./recording
//= require ./lesson_element

@LanguageLesson.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Lesson extends Entities.AssociatedModel
    urlRoot: -> Routes.lessons_path()

    rubyClass: 'Lesson'

  API =
     getLessonEntity: (id, cb) ->
       lesson = new Entities.Lesson
         id: id
       lesson.fetch
         reset: true
         success: (model, response) ->
           lesson.elements = new Entities.LessonElements(lesson.attributes.page_elements)
           cb lesson
       lesson
        
  App.reqres.setHandler "lesson:entity", (id, cb) ->
    API.getLessonEntity id, cb
