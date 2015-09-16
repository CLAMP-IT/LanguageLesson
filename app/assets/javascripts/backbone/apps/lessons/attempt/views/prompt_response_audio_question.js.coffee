//= require ./attempt.recording_element

@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.PromptResponseAudioQuestionElement extends Attempt.RecordingElement
    counter: 0

    template: 'lessons/attempt/templates/_prompt_response_audio_question'
