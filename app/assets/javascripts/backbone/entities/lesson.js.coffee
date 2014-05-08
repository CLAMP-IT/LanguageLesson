@LanguageLesson.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.LessonElement extends Entities.Model

  class Entities.LessonElements extends Entities.Collection
    model: Entities.LessonElement
  
  class Entities.Lesson extends Entities.Model
    urlRoot: -> Routes.lessons_path()
  
    #initialize: ->
    #  @elements = new Entities.LessonElements

  API =
    # getLesson: (id, cb) ->
    #   console.log("getting lesson #{id}")
    #   lesson = new Entities.Lesson
    #     id: id
    #   lesson.fetch
    #     reset: true
    #     success: ->
    #       cb lesson
    #   console.log(lesson)  
    #   lesson    
     getLessonEntity: (cb) ->
       id = 1
       lesson = new Entities.Lesson
         id: id
       lesson.fetch
         reset: true
         success: (model, response) ->
           lesson.elements = new Entities.LessonElements(lesson.attributes.page_elements)
           cb lesson
       lesson
  #App.reqres.setHandler "lesson:entities", ->
  #  API.getLesson()

  #App.reqres.setHandler "lesson:entity", (id, cb) ->
  #  API.getLesson id, cb
  
  App.reqres.setHandler "lesson:entity", (cb) ->
    API.getLessonEntity cb
