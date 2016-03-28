@LanguageLesson.module "LessonAttemptsApp.StudentReview", (StudentReview, App, Backbone, Marionette, $, _) ->
  class StudentReview.LessonInfo extends App.Views.ItemView
    template: "lesson_attempts/student_review/templates/lesson_info"
