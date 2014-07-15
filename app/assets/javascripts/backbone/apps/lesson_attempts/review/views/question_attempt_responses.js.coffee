@LanguageLesson.module "LessonAttemptsApp.Review", (Review, App, Backbone, Marionette, $, _) ->
  class Review.QuestionAttemptResponses extends App.Views.CollectionView
    childView: Review.QuestionAttemptResponse

    modelEvents:
      "updated" : "render"

    childEvents:
      "render": ->
        console.log 'a child has been rendered'
      "destroy": (view) ->
        #console.log 'child destroyed?'
        console.log @
