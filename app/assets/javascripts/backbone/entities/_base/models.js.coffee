Backbone._sync = Backbone.sync

Backbone.sync = (method, model, options) ->
  if !options.noCSRF
    beforeSend = options.beforeSend
    # Set X-CSRF-Token HTTP header

    options.beforeSend = (xhr) ->
      token = $('meta[name="csrf-token"]').attr('content')
      if token
        xhr.setRequestHeader 'X-CSRF-Token', token
      if beforeSend
        return beforeSend.apply(this, arguments)
      return

  # Serialize data, optionally using paramRoot
  if ( (typeof options.data == "undefined" or options.data == null) and model and (method == 'create' or method == 'update' or method == 'patch'))
    options.contentType = 'application/json'
    data = JSON.stringify(options.attrs or model.toJSON(options))
    if model.paramRoot
      data = {}
      data[model.paramRoot] = model.toJSON(options)
    else
      data = model.toJSON()
    options.data = JSON.stringify(data)

  Backbone._sync method, model, options

@LanguageLesson.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Model extends Backbone.Model

  class Entities.AssociatedModel extends Backbone.AssociatedModel
