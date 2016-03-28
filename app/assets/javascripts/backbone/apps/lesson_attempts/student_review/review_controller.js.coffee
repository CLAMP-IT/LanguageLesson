@LanguageLesson.module "LessonAttemptsApp.StudentReview", (StudentReview, App, Backbone, Marionette, $, _) ->
  class StudentReview.Controller extends App.Controllers.Application
    initialize: (options) ->
      @options = options

      @lesson_attempt = App.request "get:current_lesson_attempt"
      @currentUser = App.request "get:current:user"

    review: ->
      @layout = @getLayoutView(@lesson_attempt, @currentUser)

      @layout.on "show", =>
        @lessonInfo @lesson_attempt.get('lesson')
        @elements @lesson_attempt, @currentUser

      App.mainRegion.show @layout

    getLayoutView: (attempt, user) ->
      new StudentReview.Layout
        currentAttempt: attempt
        currentUser: user

    elements: (attempt, currentUser) ->
      @elementsView = @getElementsView attempt, currentUser

      @layout.elementsRegion.show @elementsView

    lessonInfo: (lesson) ->
      infoView = @getInfoView(lesson)
      @layout.infoRegion.show infoView

    getLayoutView: (attempt, user) ->
      new StudentReview.Layout
        currentAttempt: attempt
        currentUser: user

    getInfoView: (lesson) ->
      new StudentReview.LessonInfo
        model: lesson

    getElementsView: (attempt, user) ->
      new StudentReview.ElementsLayout
        model: attempt.get('lesson')
        collection: attempt.get('lesson.lesson_elements')
        currentAttempt: attempt
        currentUser: user
