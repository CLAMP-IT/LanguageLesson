@LanguageLesson.module "Entities",(Entities, App, Backbone, Marionette, $, _) ->
  class Entities.ContentBlock extends Entities.AssociatedModel
    urlRoot: -> Routes.questions_path()

    relations: [
      {
        type: Backbone.One
        key: 'recording'
        relatedModel: Entities.Recording
      }
    ]
