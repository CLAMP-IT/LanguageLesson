@LanguageLesson.module "LessonAttemptsApp.List", (List, App, Backbone, Marionette, $, _) ->
  class List.Controller extends App.Controllers.Application
    listLessonAttempts: ->
      App.request "lesson_attempt:entities", (lesson_attempts) =>
        @layout = @getLayoutView()

        @layout.on "show", =>
          @showAttemptsRegion lesson_attempts

        App.mainRegion.show @layout

    getLayoutView: ->
      new List.Layout

    getListView: (lesson_attempts) ->
      new List.LessonAttempts
        collection: lesson_attempts

    showAttemptsRegion: (lesson_attempts) ->
      listView = @getListView lesson_attempts

      @listenTo listView, "childview:edit:lesson_attempt:clicked", (iv, args) ->
        App.vent.trigger "edit:lesson_attempt:clicked", args.model

      @layout.attemptsRegion.show listView
