//= require ./student_review.recording_element

@LanguageLesson.module "LessonAttemptsApp.StudentReview", (StudentReview, App, Backbone, Marionette, $, _) ->
  class StudentReview.PromptedAudioQuestionElement extends StudentReview.RecordingElement
    template: 'lesson_attempts/student_review/templates/_prompted_audio_question'
