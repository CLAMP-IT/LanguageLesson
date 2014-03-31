class LanguageLesson.Models.Lesson extends Backbone.Model
  paramRoot: 'lesson'

  #defaults:

class LanguageLesson.Collections.LessonsCollection extends Backbone.Collection
  model: LanguageLesson.Models.Lesson
  url: '/lessons'
