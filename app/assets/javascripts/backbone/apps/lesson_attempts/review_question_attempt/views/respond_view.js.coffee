@LanguageLesson.module "LessonAttemptsApp.ReviewQuestionAttempt", (ReviewQuestionAttempt, App, Backbone, Marionette, $, _) ->
  class ReviewQuestionAttempt.Respond extends App.Views.ItemView
    template: "lesson_attempts/review_question_attempt/templates/respond"

    dialog: ->
      title: @getTitle()

    getTitle: ->
      'foo'#(if @model.isNew() then "New" else "Edit") + " Location"

    templateHelpers: ->
      #dangerLookups: @model.dangerLookups

    onShow: ->
      if @model.attributes['recordings'][0]
        @wavesurfer = Object.create(WaveSurfer)
        @showRecording @model.attributes['recordings'][0].url

    onRender: ->
      console.log 'onRender'


    showRecording: (url) ->
      console.log 'showing recording'
      console.log @
      # li = document.createElement('li')
      # au = document.createElement('audio')
      # hf = document.createElement('a')

      # au.controls = true
      # au.className = 'fooch'
      # au.src = url
      # hf.href = url
      # hf.download = new Date().toISOString() + '.wav'
      # hf.innerHTML = hf.download
      # li.appendChild(au)
      # #li.appendChild(hf)
      # $('#recordings-list').append li

      container = document.querySelector('.response_wave')

      console.log container


      @wavesurfer.init
        container     : container
        #fillParent    : true,
        #markerColor   : 'rgba(0, 0, 0, 0.5)',
        #frameMargin   : 0.1,
        #maxSecPerPx   : parseFloat(location.hash.substring(1)),
        #loadPercent   : true,
        #waveColor     : 'orange',
        #progressColor : 'red',
        #loadingColor  : 'purple',
        #xcursorColor   : 'navy',
        #waveColor: 'violet'

      @wavesurfer.on('loading', (something) ->
        console.log something
      )

      #@wavesurfer.on('ready', =>
      #  @wavesurfer.play()
      #)

      @wavesurfer.load( url )
        # Wavesurfer.on('selection-update', (selection) ->
        #   console.log selection
        # )
