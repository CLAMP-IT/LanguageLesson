@LanguageLesson.module "LessonAttemptsApp.StudentReview", (StudentReview, App, Backbone, Marionette, $, _) ->
  class StudentReview.Layout extends App.Views.Layout
    template: "lesson_attempts/student_review/templates/attempt_layout"

    initialize: (options) ->
      @currentUser = options.currentUser
      @currentAttempt = options.currentAttempt

    keys:
      'left': 'prev'
      'right': 'next'

    events:
      'click .prev': 'prev'
      'click .next': 'next'

    regions:
      infoRegion: "#info-region"
      elementsRegion: "#elements-region"
      responsesRegion: "#responses-region"
    next: =>
      App.trigger('student_review:next_element')

    prev: =>
      App.trigger('student_review:previous_element')
