@LanguageLesson.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Institution extends Entities.AssociatedModel

  API =
    getCurrentInstitution: ->
      App.currentInstitution

    setCurrentInstitution: (institution) ->
      App.currentInstitution = new Entities.Institution institution

      App.currentInstitution

    getInstitutionEntities: (cb) ->
      institutions = new Entities.InstitutionsCollection
      institutions.fetch
        success: ->
          cb institutions

  App.reqres.setHandler "get:current:institution", ->
    API.getCurrentInstitution()

  App.reqres.setHandler "set:current:institution", (currentInstitution) ->
    API.setCurrentInstitution currentInstitution

  App.reqres.setHandler "institution:entities", (cb) ->
    API.getInstitutionEntities cb
