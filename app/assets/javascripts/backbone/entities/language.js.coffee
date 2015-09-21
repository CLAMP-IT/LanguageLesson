@LanguageLesson.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Language extends Entities.AssociatedModel
    urlRoot: -> Routes.languages_path()

    relations: [
      {
        type: Backbone.Many
        key: 'lessons'
        collectionType: 'LanguageLesson.Entities.LessonsCollection'
      }
    ]
    defaults:
      lessons: []

  class Entities.LanguagesCollection extends Entities.Collection
    model: Entities.Language
    url: -> Routes.with_lessons_languages_path()

  API =
    getLanguageEntity: (id, cb) ->
      language = new Entities.Language
        id: id
      language.fetch
        reset: true
        success: (model, response) ->
          cb language
      language

    getLanguagesEntities: (cb) ->
      languages = new Entities.LanguagesCollection

      languages.fetch
        success: ->
          cb languages

  App.reqres.setHandler "language:entity", (id, cb) ->
    API.getLanguageEntity id, cb

  App.reqres.setHandler "languages:entities", (cb) ->
    API.getLanguagesEntities cb
