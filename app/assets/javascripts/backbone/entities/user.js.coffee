@LanguageLesson.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.User extends Entities.AssociatedModel
    relations: [
      {
        type: Backbone.Many
        key: 'question_attempts'
        collectionType: 'LanguageLesson.Entities.QuestionAttempts'
      }
    ]

  class Entities.UsersCollection extends Entities.Collection
    model: Entities.User
    url: -> Routes.users_path()

  API =
    setCurrentUser: (user) ->
      App.currentUser = new Entities.User user

      App.currentUser

    getCurrentUser: ->
      App.currentUser

    getUserEntities: (cb) ->
      users = new Entities.UsersCollection
      users.fetch
        success: ->
          cb users

    getUserEntitiesFromArray: (users) ->
      new Entities.UsersCollection users

  App.reqres.setHandler "get:current:user", ->
    API.getCurrentUser()

  App.reqres.setHandler "set:current:user", (user) ->
    API.setCurrentUser user

  App.reqres.setHandler "user:entities", (cb) ->
    API.getUserEntities cb

  App.reqres.setHandler "user:entities:from_array", (users) ->
    API.getUserEntitiesFromArray users
