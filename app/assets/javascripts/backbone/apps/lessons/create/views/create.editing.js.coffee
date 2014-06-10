//= require jquery.notebook
//= require medium-editor

@LanguageLesson.module "LessonsApp.Create", (Create, App, Backbone, Marionette, $, _) ->
  class Create.EditingView extends App.Views.ItemView
    template: "lessons/create/templates/create_editing"

    onShow: ->
      editor = new MediumEditor('#editor')
      #$('#editor').notebook()
