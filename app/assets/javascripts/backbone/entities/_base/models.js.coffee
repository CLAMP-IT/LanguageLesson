@LanguageLesson.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	class Entities.Model extends Backbone.Model

  class Entities.AssociatedModel extends Backbone.AssociatedModel
