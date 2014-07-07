@LanguageLesson.module "Concerns", (Concerns, App, Backbone, Marionette, $, _) ->
  Concerns.Chooser =
    initialize: ->
      new Backbone.Chooser @

  Concerns.SingleChooser =
    beforeIncluded: (klass, concern) ->
      klass::model.include "Chooser"

    initialize: ->
      new Backbone.SingleChooser @
