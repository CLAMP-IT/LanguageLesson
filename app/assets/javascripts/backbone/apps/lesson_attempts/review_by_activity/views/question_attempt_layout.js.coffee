@LanguageLesson.module "LessonAttemptsApp.ReviewByActivity", (ReviewByActivity, App, Backbone, Marionette, $, _) ->
  class ReviewByActivity.QuestionAttemptLayout extends App.Views.Layout
    template: "lesson_attempts/review_by_activity/templates/question_attempt_layout"

    initialize: ->
      @responses_to_regions = { }
      @regions_to_responses = { }

    events:
      "click .js-lesson-attempt-nav" : ->
        App.vent.trigger 'lesson_attempt:review_by_activity:show_overview'

    regions:
      questionAttemptInfoRegion: '#question-attempt-info-region'
      questionRegion: '#question-region'
      responseRegion: "#response-region"
      commentRegion: "#comments-region"

    showQuestionAttempt: (question_attempt) ->
      @question_attempt_info_view = new ReviewByActivity.QuestionAttemptInfo
        model: question_attempt

      @questionAttemptInfoRegion.show @question_attempt_info_view

      @question_attempt_view = new ReviewByActivity.QuestionAttempt
        model: question_attempt

      @questionRegion.show @question_attempt_view

      @responses_view = new ReviewByActivity.QuestionAttemptResponses
        collection: question_attempt.get('responses')

      @listenTo @responses_view, "childview:question_attempt_response:selected", (iv, args) ->
        @activateRegion @responses_to_regions[args.model.cid]

      @listenTo @responses_view, "childview:question_attempt_response:deselected", (iv, args) ->
        @deactivateRegion @responses_to_regions[args.model.cid]

      @listenTo @responses_view, "childview:question_attempt_response:play_region", (iv, args) ->
        @responses_to_regions[args.model.cid].play()

      @listenTo @responses_view, 'question_attempt_responses:child_destroyed', ->
        @initializeRegions()

      @listenTo @responses_view, "childview:question_attempt_response:destroyed", (iv) ->
        @initializeRegions()

      @listenTo @question_attempt_view, "question_attempt:add_region_with_model", (region, question_attempt_response) ->
        view = @responses_view.children.findByModel(question_attempt_response)

        @responses_to_regions[view.model.cid] = region
        @regions_to_responses[region.id] = view

      @listenTo @question_attempt_view, "question_attempt:region_entered", (region) ->
        @activateRegion(region)

      @listenTo @question_attempt_view, "question_attempt:region_left", (region) ->
        @deactivateRegion(region)

      @listenTo @question_attempt_view, "question_attempt:initialize_regions", ->
        @initializeRegions()

      @listenTo @question_attempt_view, "question_attempt:new_response", (new_response) ->
        @question_attempt_view.new_response_view = @responses_view.children.findByModel(new_response)

      @responseRegion.show @responses_view

    activateRegion: (region) ->
      question_attempt_response = @regions_to_responses[region.id]

      if question_attempt_response
        @regions_to_responses[region.id].highlight()

        @responses_to_regions[question_attempt_response.model.cid].update(
          color: "rgba(255, 0, 0, 0.1)"
        )

    deactivateRegion: (region) ->
      question_attempt_response = @regions_to_responses[region.id]

      if question_attempt_response
        @regions_to_responses[region.id].dehighlight()

        @responses_to_regions[question_attempt_response.model.cid].update(
          color: "rgba(100, 100, 100, 0.1)"
        )

    initializeRegions: =>
      @question_attempt_view.wavesurfer.clearRegions()

      @responses_to_regions = {}
      @regions_to_responses = {}

      @responses_view.children.each (question_attempt_response) =>
        new_region = @question_attempt_view.wavesurfer.addRegion(
          start: question_attempt_response.model.get('mark_start'),
          end: question_attempt_response.model.get('mark_end'),
          color: "rgba(100, 100, 100, 0.1)",
          drag: false
        )

        @responses_to_regions[question_attempt_response.model.cid] = new_region
        @regions_to_responses[new_region.id] = question_attempt_response
