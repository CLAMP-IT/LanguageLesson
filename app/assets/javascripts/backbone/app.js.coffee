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
    App.request "set:administrator_status", options.administrator

    return

  App.reqres.setHandler "get:current:user", ->
    App.currentUser

  App.reqres.setHandler "get:administrator_status", ->
    App.administrator_status

  App.reqres.setHandler "set:administrator_status", (status) ->
    App.administrator_status = status

  App.on "start", ->
    ## create our specialized dialog region
    @addRegions dialogRegion: { selector: "#dialog-region", regionType: App.Regions.Modal }

    @currentInstitution = App.request "get:current:institution"

    @currentActivity = App.request "get:current:activity"

    @is_admin = App.request "get:administrator_status"

    if @currentActivity
      if Backbone.history
        Backbone.history.start
          pushState: true
          root: "/lti/start"
          silent: true

      if @currentActivity.get('doable_id')
        if @currentActivity.get('doable_type') == "Lesson"
          if @is_admin
            App.navigate("lesson_attempts/#{@currentActivity.get('id')}/review_by_activity", trigger: true)
          else
            App.navigate("lessons/#{@currentActivity.get('doable_id')}/attempt", trigger: true)
      else
        App.navigate("activities/#{@currentActivity.get('id')}/choose_doable", trigger: true)
    else
      if Backbone.history
        Backbone.history.start()
  App
