@LanguageLesson.module "Entities",(Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Question extends Entities.AssociatedModel
    urlRoot: -> Routes.questions_path()

  class Entities.QuestionAttempts extends Entities.Collection
    model: Entities.QuestionAttempt

