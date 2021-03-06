@LanguageLesson.module "LessonsApp.Show", (Show, App, Backbone, Marionette, $, _) ->      
  class Show.Controller extends App.Controllers.Application
    showLesson: (id) ->
      App.request "lesson:entity", id, (lesson) =>
        @layout = @getLayoutView(lesson)
                        
        @layout.on "show", =>
          @showLessonInfo lesson
          @showElements lesson
                      
        App.mainRegion.show @layout

    showElements: (lesson) ->
      elementsView = @getElementsView lesson
      @layout.elementsRegion.show elementsView
                
    showLessonInfo: (lesson) ->
      infoView = @getInfoView(lesson)
      @layout.infoRegion.show infoView                   
                
    getLayoutView: ->      
      new Show.Layout

    getInfoView: (lesson) ->
      new Show.LessonInfo
        model: lesson

    getElementsView: (lesson) ->
      new Show.Elements
        model: lesson
        collection: lesson.elements
        foo: 'bar'
      
