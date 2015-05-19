@LanguageLesson.module "Entities", (Entities, App, Backbone, Marionette, $, _) -> 
  class Entities.Institution extends Entities.AssociatedModel      

  API =
    setCurrentInstitution: (currentInstitution) ->
      App.currentInstitution = new Entities.Institution currentInstitution
                
    getInstitutionEntities: (cb) ->
      institutions = new Entities.InstitutionsCollection
      institutions.fetch
        success: ->
          cb institutions
        
  App.reqres.setHandler "set:current:institution", (currentInstitution) ->
    API.setCurrentInstitution currentInstitution
       
  App.reqres.setHandler "institution:entities", (cb) ->
    API.getInstitutionEntities cb
