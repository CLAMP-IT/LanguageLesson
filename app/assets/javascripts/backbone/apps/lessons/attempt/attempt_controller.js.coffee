//= require recorder_controls

@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->      
  class Attempt.Controller extends App.Controllers.Application
    initialize: (options) ->
      App.vent.on 'lesson:prevent_stepping_forward', ->
        return
      
    attemptLesson: (lesson_id) ->
      RecorderControls.initialize()
      
      currentUser = App.request "get:current:user"

      App.request "lesson:entity", lesson_id, (lesson) =>
        App.request "new:lesson_attempt:entity", lesson, currentUser, (attempt) =>
          @layout = @getLayoutView(attempt, currentUser)
        
          @layout.on "show", =>
            @attemptLessonInfo attempt.get('lesson')
            @attemptElements attempt, currentUser
                      
          App.mainRegion.show @layout

    attemptElements: (attempt, currentUser) ->
      elementsView = @getElementsView attempt, currentUser

      @layout.elementsRegion.show elementsView
                
    attemptLessonInfo: (lesson) ->
      infoView = @getInfoView(lesson)
      @layout.infoRegion.show infoView                   
                
    getLayoutView: (attempt, user) ->      
      new Attempt.Layout
        attempt: attempt
        currentUser: user

    getInfoView: (lesson) ->
      new Attempt.LessonInfo
        model: lesson

    getElementsView: (attempt, currentUser) ->
      new Attempt.Elements
        model: attempt.get('lesson')
        collection: attempt.get('lesson').elements
        attempt: attempt
        user: currentUser
