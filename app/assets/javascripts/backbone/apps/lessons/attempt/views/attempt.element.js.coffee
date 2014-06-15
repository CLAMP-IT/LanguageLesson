@LanguageLesson.module "LessonsApp.Attempt", (Attempt, App, Backbone, Marionette, $, _) ->
  class Attempt.Element extends App.Views.ItemView
    template: "lessons/attempt/templates/_bare_element"
    
    tagName: 'div'

      

   
