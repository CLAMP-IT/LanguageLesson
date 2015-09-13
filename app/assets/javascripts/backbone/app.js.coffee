@LanguageLesson = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.addRegions
    headerRegion: "#header-region"
    mainRegion: "#main-region"
    footerRegion: "#footer-region"

  App.on "before:start", (options) ->
    App.request "set:current:user", options.user if options.user
    App.request "set:current:institution", options.institution if options.institution
    App.request "set:current:activity", options.activity if options.activity

    return

  App.reqres.setHandler "get:current:user", ->
    App.currentUser

  App.on "start", ->
    ## create our specialized dialog region
    @addRegions dialogRegion: { selector: "#dialog-region", regionType: App.Regions.Modal }

    @currentInstitution = App.request "get:current:institution"

    @currentActivity = App.request "get:current:activity"

    if @currentActivity
      if Backbone.history
        Backbone.history.start
          pushState: true
          root: "/lti/start"
          silent: true

      if @currentActivity.get('doable_id')
        if @currentActivity.get('doable_type') == "Lesson"
          App.navigate("lessons/#{@currentActivity.get('doable_id')}/attempt", trigger: true)
      else
        App.navigate("activities/#{@currentActivity.get('id')}/choose_doable", trigger: true)
    else
      if Backbone.history
        Backbone.history.start()
  App
