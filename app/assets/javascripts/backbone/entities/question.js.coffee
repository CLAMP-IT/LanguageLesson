@LanguageLesson.module "Entities",(Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Question extends Entities.AssociatedModel
    urlRoot: -> Routes.questions_path()

  class Entities.QuestionsCollection extends Entities.Collection
    model: Entities.Question

  API =
    getQuestionEntitiesFromArray: (question_data) ->
      new Entities.QuestionsCollection question_data

  App.reqres.setHandler "question:entities:from_array", (question_data) ->
    API.getQuestionEntitiesFromArray question_data
