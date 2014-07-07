@LanguageLesson.module "Regions", (Regions, App, Backbone, Marionette, $, _) ->
  class Regions.Modal extends Marionette.Region
    constructor: ->
      Marionette.Region.prototype.constructor.apply(@, arguments)
 
      @ensureEl()
      @$el.on('hidden', {region:this}, (event) ->
        event.data.region.close()
      )
      
    onShow: ->
      #@$el.modal('show')
      $('#dialog').modal('show')
 
    onClose: -> 
      @$el.modal('hide')
