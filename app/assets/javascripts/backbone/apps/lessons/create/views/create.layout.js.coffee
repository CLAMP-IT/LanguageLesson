@LanguageLesson.module "LessonsApp.Create", (Create, App, Backbone, Marionette, $, _) ->
  class Create.Layout extends App.Views.Layout
    template: "lessons/create/templates/create_layout"

    regions:
      paletteRegion: "#palette-region"
      arrangementRegion: "#arrangement-region"
      editingRegion: "#editing-region"
