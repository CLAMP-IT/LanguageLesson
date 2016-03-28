//= require ./student_review.recording_element

@LanguageLesson.module "LessonAttemptsApp.StudentReview", (StudentReview, App, Backbone, Marionette, $, _) ->
  class StudentReview.PromptResponseAudioQuestionElement extends StudentReview.RecordingElement
    template: 'lesson_attempts/student_review/templates/_prompt_response_audio_question'
