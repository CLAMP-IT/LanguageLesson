@LanguageLesson.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.User extends Entities.AssociatedModel

  class Entities.UsersCollection extends Entities.Collection
    model: Entities.User
    url: -> Routes.users_path()

  API =
    setCurrentUser: (currentUser) ->
      App.currentUser = new Entities.User currentUser

      App.currentUser

    getCurrentUser: ->
      App.currentUser

    getUserEntities: (cb) ->
      users = new Entities.UsersCollection
      users.fetch
        success: ->
          cb users

  App.reqres.setHandler "set:current:user", (currentUser) ->
    API.setCurrentUser currentUser

  App.reqres.setHandler "user:entities", (cb) ->
    API.getUserEntities cb
