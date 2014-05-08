@LanguageLesson.module "Views", (Views, App, Backbone, Marionette, $, _) ->
  _.extend Marionette.View::,
    templateHelpers: ->
      linkTo: (name, url, options = {}) ->
        _.defaults options,
	        external: false
				
      	#url = "#" + url unless options.external
				
	      #"<a href='#{url}'>#{@escape(name)}</a>"
