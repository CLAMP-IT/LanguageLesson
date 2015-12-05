@LanguageLesson.module "LessonAttemptsApp.ReviewByActivity", (ReviewByActivity, App, Backbone, Marionette, $, _) ->
  class ReviewByActivity.QuestionAttempt extends App.Views.ItemView
    template: "lesson_attempts/review_by_activity/templates/question_attempt"

    initialize: ->
      @wavesurfer = Object.create(WaveSurfer)

    onShow: ->
      if @model.get('recording')
        @showRecording @model.get('recording.full_url')

    showRecording: (url) ->
      @wavesurfer.init
        container: '.response_wave'

      # Initialize regions in the layout
      @wavesurfer.on 'ready', =>
        @trigger("question_attempt:initialize_regions")

      @wavesurfer.load( url )

      @wavesurfer.enableDragSelection(
        color: "rgba(255, 0, 0, 0.1)",
        drag: false
      )

      @$('.js-play-pause').click =>
        @wavesurfer.play()

      @wavesurfer.on('region-mouseenter', (region) =>
        @trigger("question_attempt:region_entered", region)
      )

      @wavesurfer.on('region-mouseleave', (region) =>
        @trigger("question_attempt:region_left", region)
      )

      @wavesurfer.on('region-update-end', (region) =>
        new_response = App.request "create:question_attempt_response:entity", (@model)
        new_response.set('mark_start', region.start)
        new_response.set('mark_end', region.end)

        @model.get('responses').push new_response

        @trigger("question_attempt:add_region_with_model", region, new_response)
      )
