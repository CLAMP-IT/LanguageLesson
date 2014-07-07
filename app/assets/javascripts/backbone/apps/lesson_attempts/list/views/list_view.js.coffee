@LanguageLesson.module "LessonAttemptsApp.List", (List, App, Backbone, Marionette, $, _) ->
  class List.Layout extends App.Views.Layout
    template: "lesson_attempts/list/templates/list_layout"

    regions:
      attemptsRegion:  "#attempts-region"

  class List.LessonAttempt extends App.Views.ItemView
    template: "lesson_attempts/list/templates/_lesson_attempt"
    tagName: "tr"

    modelEvents:
      "updated" : "render"

    triggers:
      "click [data-js-edit]" : "edit:lesson_attempt:clicked"
     
    #@include "Chooseable"

  class List.LessonAttempts extends App.Views.CompositeView
    template: "lesson_attempts/list/templates/_lesson_attempts"
    itemView: List.LessonAttempt
    itemViewContainer: "tbody"
