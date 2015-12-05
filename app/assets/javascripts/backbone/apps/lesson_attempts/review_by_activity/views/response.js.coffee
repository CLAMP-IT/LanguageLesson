@LanguageLesson.module "LessonAttemptsApp.ReviewByActivity", (ReviewByActivity, App, Backbone, Marionette, $, _) ->
  class ReviewByActivity.Response extends App.Views.ItemView
    template: "lesson_attempts/review_by_activity/templates/response"

    initialize: ->
      @wavesurfer = Object.create(WaveSurfer)

      @question_attempt_responses = { }
      @regions = { }
      @regions_to_responses = { }

    onShow: ->
      if @model.get('recording')
        @showRecording @model.get('recording.full_url')

    activateRegion: (question_attempt_response) ->
      @regions[question_attempt_response.model.cid].update(
        color: "rgba(255, 0, 0, 0.1)"
      )

    deactivateRegion: (question_attempt_response) ->
      @regions[question_attempt_response.model.cid].update(
        color: "rgba(100, 100, 100, 0.1)"
      )

    addRegion: (question_attempt_response) ->
      console.log 'adding region', question_attempt_response

      @question_attempt_responses[question_attempt_response.cid] = question_attempt_response

    showRecording: (url) ->
      @wavesurfer.init
        container: '.response_wave'

      # Display regions and store references in the regions hash
      @wavesurfer.on 'ready', =>
        for cid, question_attempt_response of @question_attempt_responses
          console.log question_attempt_response
          new_region = @wavesurfer.addRegion(
            start: question_attempt_response.model.get('mark_start'),
            end: question_attempt_response.model.get('mark_end'),
            color: "rgba(100, 100, 100, 0.1)",
            drag: false
          )

          @regions[question_attempt_response.model.cid] = new_region
          @regions_to_responses[new_region.id] = question_attempt_response

      @wavesurfer.load( url )

      @wavesurfer.enableDragSelection(
        color: "rgba(255, 0, 0, 0.1)",
        drag: false
      )

      @$('.js-play-pause').click =>
        @wavesurfer.play()

      @wavesurfer.on('region-mouseenter', (region) =>
        console.log region
        @regions_to_responses[region.id].highlight()
        @activateRegion(@regions_to_responses[region.id])
      )

      @wavesurfer.on('region-mouseleave', (region) =>
        @regions_to_responses[region.id].dehighlight()
        @deactivateRegion(@regions_to_responses[region.id])
      )

      @wavesurfer.on('region-update-end', (region) =>
        console.log "region-update-end callback", region

        new_response = App.request "create:question_attempt_response:entity", (@model)
        new_response.set('mark_start', region.start)
        new_response.set('mark_end', region.end)

        @model.get('responses').push new_response

        #console.log 'fie', @#model.get('responses')#.children.findByModel(new_response)
        new_response_view = @trigger('question_attempt:new_response', new_response)
        @question_attempt_responses[new_response.cid] = new_response_view
        @regions[new_response.cid] = region
        @regions_to_responses[new_region.id] = new_response
        console.log "here", new_region.id, new_response
        console.log @regions_to_responses
      )
