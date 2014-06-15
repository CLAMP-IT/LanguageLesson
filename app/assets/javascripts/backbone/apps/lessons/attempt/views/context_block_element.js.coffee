//= require ./attempt.element

@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.ContentBlockElement extends Attempt.Element
    template: 'lessons/attempt/templates/_content_block'
