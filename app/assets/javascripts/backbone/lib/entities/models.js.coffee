@LanguageLesson.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Model extends Backbone.Model

    destroy: (options = {}) ->
      _.defaults options,
        wait: true

      @set _destroy: true
      super options

    isDestroyed: ->
      @get "_destroy"

    save: (data, options = {}) ->
      isNew = @isNew()

      _.defaults options,
        wait: true
        success:   _.bind(@saveSuccess, @, isNew, options.collection, options.callback)
        error:    _.bind(@saveError, @)

      @unset "_errors"
      super data, options

    saveSuccess: (isNew, collection, callback) =>
      if isNew ## model is being created
        collection?.add @
        collection?.trigger "model:created", @
        @trigger "created", @
      else ## model is being updated
        collection ?= @collection ## if model has collection property defined, use that if no collection option exists
        collection?.trigger "model:updated", @
        @trigger "updated", @

      callback?()

    saveError: (model, xhr, options) =>
      ## set errors directly on the model unless status returned was 500 or 404
      @set _errors: $.parseJSON(xhr.responseText)?.errors unless /500|404/.test xhr.status

  API =
    newModel: (attrs) ->
      new Entities.Model attrs

  App.reqres.setHandler "new:model", (attrs = {}) ->
    API.newModel attrs
