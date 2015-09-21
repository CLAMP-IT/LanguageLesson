@LanguageLesson.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.LessonElement extends Entities.AssociatedModel
    relations: [
      {
        type: Backbone.One
        key: 'recording'
        relatedModel: 'LanguageLesson.Entities.Recording'
      }
    ]
    defaults:
      recording: null

  class Entities.LessonElements extends Entities.Collection
    model: Entities.LessonElement
