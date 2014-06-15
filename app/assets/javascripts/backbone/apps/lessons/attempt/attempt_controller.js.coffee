//= require recordfoo

@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->      
  class Attempt.Controller extends App.Controllers.Application #Attempt.Controller =
    initialize: (options) ->
      App.vent.on 'lesson:prevent_stepping_forward', ->
        console.log 'preventing in the controller'
        return
      
    attemptLesson: (lesson_id) ->
      currentUser = App.request "get:current:user"

      RecorderControls.initialize()

      App.request "new:lesson_attempt:entity", lesson_id, currentUser.id, (attempt) =>
        @layout = @getLayoutView(attempt, currentUser)
        
        @layout.on "show", =>
          @attemptLessonInfo attempt.lesson
          @attemptElements attempt
                      
        App.mainRegion.show @layout

    attemptElements: (attempt) ->
      elementsView = @getElementsView attempt

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

    getElementsView: (attempt) ->
      new Attempt.Elements
        model: attempt.lesson
        collection: attempt.lesson.elements
        attempt: attempt
