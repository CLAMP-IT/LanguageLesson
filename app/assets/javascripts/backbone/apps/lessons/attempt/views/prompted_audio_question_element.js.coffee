//= require ./attempt.recording_element

@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.PromptedAudioQuestionElement extends Attempt.RecordingElement
    template: 'lessons/attempt/templates/_prompted_audio_question'
