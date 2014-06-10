@LanguageLesson.module "LessonsApp.Create", (Create, App, Backbone, Marionette, $, _) ->      
  Create.Controller  =
    createLesson: () ->
      @layout = @getLayoutView()
                      
      @layout.on "show", =>
        console.log 'here?'

        @showPaletteRegion()
        @showArrangementRegion()
        @showEditingRegion()
                         
      App.mainRegion.show @layout

    getLayoutView: ->      
      new Create.Layout

    showPaletteRegion: () ->
      @layout.paletteRegion.show new Create.PaletteView

    showArrangementRegion: ->
      @layout.arrangementRegion.show new Create.ArrangementView   
          
    showEditingRegion: ->
      @layout.editingRegion.show new Create.EditingView      
