@LanguageLesson = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.addRegions
    headerRegion: "#header-region"
    mainRegion: "#main-region"
    footerRegion: "#footer-region"

  App.on "before:start", (options) ->
    @currentUser = App.request "set:current:user", options.currentUser

  App.reqres.setHandler "get:current:user", ->
    App.currentUser

  #App.reqres.setHandler "concern", (concern) -> App.Concerns[concern]

  App.on "start", ->
    ## create our specialized dialog region
    @addRegions dialogRegion: { selector: "#dialog-region", regionType: App.Regions.Modal }

    if Backbone.history
      Backbone.history.start()

  App
