//= require_tree ./views

@LanguageLesson.module "ActivitiesApp.Choose", (Choose, App, Backbone, Marionette, $, _) ->
  class Choose.Controller extends App.Controllers.Application
    chooseDoable: (id) ->
      App.vent.on "select:lesson:clicked", (iv, args) ->
        activity = App.request "get:current:activity"
        activity.set('doable_type', 'Lesson')
        activity.set('doable_id', iv.model.get('id'))

        activity.save(
          null
          success: =>
            App.navigate("lesson_attempts/#{activity.get('id')}/review_by_activity", trigger: true)
        )

      App.request "languages:entities", (lessons_by_language) =>
        @layout = @getLayoutView()
        @layout.on "show", =>
          @showLessonsRegion lessons_by_language
        App.mainRegion.show @layout

    getLayoutView: ->
      new Choose.Layout

    getChooseView: (lessons_by_language) ->
      new Choose.LessonsByLanguage
        collection: lessons_by_language

    showLessonsRegion: (lessons_by_language) ->
      listView = @getChooseView lessons_by_language

      @layout.lessonsRegion.show listView
