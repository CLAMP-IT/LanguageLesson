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

    if (gon.activity)
      if Backbone.history
        Backbone.history.start
          pushState: true
          root: "/lti/start"
          silent: true

      @currentInstitution = App.request "set:current:institution", gon.institution
      console.log @currentInstitution
      console.log gon.user
      console.log gon.role
      console.log gon.course
      console.log gon.activity

      if gon.activity.doable_id
        if gon.activity.doable_type == "Lesson"
          App.navigate("lessons/#{gon.activity.doable_id}/attempt", trigger: true)
      else
        console.log "Nothing doable"
        App.navigate("activities/#{gon.activity.id}/choose_doable", trigger: true)
        #App.navigate("lessons/1/attempt", trigger: true)
    else
      if Backbone.history
        Backbone.history.start()
  App
