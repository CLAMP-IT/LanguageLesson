@LanguageLesson = do (Backbone, Marionette) ->
	App = new Marionette.Application
	
	App.addRegions
		headerRegion: "#header-region"
		mainRegion: "#main-region"
		footerRegion: "#footer-region"
	
  App.on "initialize:before", (options) ->
    @currentUser = App.request "set:current:user", options.currentUser

  App.reqres.setHandler "get:current:user", ->
    App.currentUser
  
	App.on "initialize:after", ->
		if Backbone.history
			Backbone.history.start()
	
	App
