//= require ./student_review.element

@LanguageLesson.module "LessonAttemptsApp.StudentReview", (StudentReview, App, Backbone, Marionette, $, _) ->
  class StudentReview.ContentBlockElement extends StudentReview.Element
    template: 'lesson_attempts/student_review/templates/_content_block'

    onShow: ->
      # Allow stepping forward in case it was
      # prevented previously
      App.vent.trigger "lesson:allow_stepping_forward"
