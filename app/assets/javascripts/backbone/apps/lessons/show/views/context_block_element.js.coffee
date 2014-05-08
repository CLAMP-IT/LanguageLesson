//= require ./show.element

@LanguageLesson.module "LessonsApp.Show", (Show, App, Backbone, Marionette, $, _) ->
  class Show.ContentBlockElement extends Show.Element
    template: 'lessons/show/templates/_content_block'
