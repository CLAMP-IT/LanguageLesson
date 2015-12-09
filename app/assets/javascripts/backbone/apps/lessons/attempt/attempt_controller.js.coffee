//= require recorder_controls

@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.Controller extends App.Controllers.Application
    initialize: (options) ->
      @currentUser = App.request "get:current:user"
      @currentActivity = App.request "get:current:activity"
      @currentAttempt = null
      @currentLesson = null
      @currentRecording = null
      @currentElement = null

      App.vent.on 'lesson:prevent_stepping_forward', ->
        return

      App.vent.on 'lesson:play_recording', ->
        audio = document.getElementById('hidden-audio')
        audio.play() if audio.src

      App.vent.on 'lesson:set_current_recording', (recording) ->
        @currentRecording = recording
        document.getElementById('hidden-audio').src = @currentRecording.getUrl()

    acceptRecording: (recording) =>
      console.log 'received recording', recording
      @currentRecording = App.request "create:recording:entity"
      @currentRecording.set('blob', recording)

      audio = document.getElementById('hidden-audio')
      audio.src = @currentRecording.getUrl()

      @elementsView.applyRecording(@currentRecording)

    attemptLesson: (lesson_id) ->
      RecorderControls.initialize()
      RecorderControls.setRecordingAcceptor(@)
      #RecorderControls.recorder.addEventListener 'dataAvailable', @handleRecording

      create_attempt = App.request "new:lesson_attempt:entity", lesson_id, @currentUser.get('id'), @currentActivity.get('id')

      create_attempt.done (attempt) =>
        @currentAttempt = attempt
        @currentLesson = attempt.get('lesson')

        @layout = @getLayoutView(attempt, @currentUser)

        @layout.on "show", =>
          @attemptLessonInfo attempt.get('lesson')
          @attemptElements attempt, @currentUser

        App.mainRegion.show @layout

    attemptElements: (attempt, currentUser) ->
      @elementsView = @getElementsView attempt, currentUser

      @layout.elementsRegion.show @elementsView

    attemptLessonInfo: (lesson) ->
      infoView = @getInfoView(lesson)
      @layout.infoRegion.show infoView

    getLayoutView: (attempt, user) ->
      new Attempt.Layout
        currentAttempt: attempt
        currentUser: user

    getInfoView: (lesson) ->
      new Attempt.LessonInfo
        model: lesson

    getElementsView: (attempt, user) ->
      new Attempt.Elements
        model: attempt.get('lesson')
        collection: attempt.get('lesson.lesson_elements')
        currentAttempt: attempt
        currentUser: user
