@LanguageLesson.module "LessonAttemptsApp.ReviewByActivity", (ReviewByActivity, App, Backbone, Marionette, $, _) ->
  class ReviewByActivity.UserRow extends App.Views.CompositeView
    template: "lesson_attempts/review_by_activity/templates/user_row"

    childView: ReviewByActivity.QuestionBox

    className: 'flex-row'

    onChildviewFindQuestionAttempt: (iv, args) ->
      question_attempt = _.find @model.get('question_attempts').models, (question_attempt) ->
        question_attempt.get('question_id') == args.get('id')

      args.set('question_attempt', question_attempt)

    initialize: (options) ->
      @options = options

      @collection = App.request "lesson_attempt:review_by_activity:get_questions"

      App.reqres.setHandler 'lesson_attempt:review_by_activity:determine_question_state', (question) =>
        matching_attempts = _.filter @model.get('question_attempts').models, (question_attempt) ->
          question_attempt.get('question_id') == question.get('id')

        if matching_attempts.length
          if _.isEmpty matching_attempts[0].get('responses').models
            return 'box attempted'
          else
            return 'box responded'
          end
        else
          return 'box unattempted'
