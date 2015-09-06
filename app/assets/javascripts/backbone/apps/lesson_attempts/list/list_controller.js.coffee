@LanguageLesson.module "LessonAttemptsApp.List", (List, App, Backbone, Marionette, $, _) ->
  class List.Controller extends App.Controllers.Application
    listLessonAttempts: ->
      App.request "lesson_attempt:entities", (lesson_attempts) =>
        console.log lesson_attempts#.models[0].get('user')

        @layout = @getLayoutView()

        @layout.on "show", =>
    #       @showLessonAttemptInfo lesson
           @showAttemptsRegion lesson_attempts

        App.mainRegion.show @layout

    # showElements: (lesson) ->
    #   elementsView = @getElementsView lesson
    #   @layout.elementsRegion.show elementsView

    # showLessonAttemptInfo: (lesson) ->
    #   infoView = @getInfoView(lesson)
    #   @layout.infoRegion.show infoView

    getLayoutView: ->
      new List.Layout

    # getInfoView: (lesson) ->
    #   new Show.LessonAttemptInfo
    #     model: lesson

    # getElementsView: (lesson) ->
    #   new Show.Elements
    #     model: lesson
    #     collection: lesson.elements
    #     foo: 'bar'

    getListView: (lesson_attempts) ->
      new List.LessonAttempts
        collection: lesson_attempts

    showAttemptsRegion: (lesson_attempts) ->
      listView = @getListView lesson_attempts
      console.log @layout

      #@listenTo locations, "model:created", (location) ->
      #  location.choose()

      @listenTo listView, "childview:edit:lesson_attempt:clicked", (iv, args) ->
        console.log args
        # args.model.choose()
        App.vent.trigger "edit:lesson_attempt:clicked", args.model

      #  App.vent.trigger "edit:location:clicked", args.model

      #@listenTo listView, "childview:destroy:location:clicked", (iv, args) ->
      #  { model } = args
      #  if confirm "Are you sure you want to delete: #{model.get("name")}" then model.destroy() else false

      @layout.attemptsRegion.show listView
