@LanguageLesson = do (Backbone, Marionette) ->
	App = new Marionette.Application
	
	App.addRegions
		headerRegion: "#header-region"
		mainRegion: "#main-region"
		footerRegion: "#footer-region"
	
	App.addInitializer ->
	
	App.on "initialize:after", ->
		if Backbone.history
			Backbone.history.start()
	
	App
