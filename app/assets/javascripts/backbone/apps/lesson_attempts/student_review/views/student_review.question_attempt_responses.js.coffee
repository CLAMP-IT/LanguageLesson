@LanguageLesson.module "LessonAttemptsApp.StudentReview", (StudentReview, App, Backbone, Marionette, $, _) ->
  class StudentReview.QuestionAttemptResponses extends App.Views.CollectionView
    childView: StudentReview.QuestionAttemptResponse
