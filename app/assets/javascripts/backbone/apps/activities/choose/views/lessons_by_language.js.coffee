@LanguageLesson.module "ActivitiesApp.Choose", (Choose, App, Backbone, Marionette, $, _) ->
  class Choose.LessonRow extends App.Views.ItemView
    template: "activities/choose/templates/_lesson_row"
    #tagName: "cell"

    triggers:
      "click [data-js-select]" : "select:lesson:clicked"

  class Choose.LanguageRow extends App.Views.CompositeView
    template: "activities/choose/templates/_language_row"
    childView: Choose.LessonRow
    #tagName: "cell"

    onChildviewSelectLessonClicked: (iv, args) ->
    #  console.log "hello", iv,args
      App.vent.trigger "select:lesson:clicked", iv, args

    initialize: ->
      @collection = @model.get('lessons')

  class Choose.LessonsByLanguage extends App.Views.CompositeView
    template: "activities/choose/templates/_lessons_by_language"
    childView: Choose.LanguageRow
    childViewContainer: "tbody"

    onChildviewSelectLessonClicked: ->
      console.log('gah')

    onSelectLessonClicked: ->
      console.log('gah2')
