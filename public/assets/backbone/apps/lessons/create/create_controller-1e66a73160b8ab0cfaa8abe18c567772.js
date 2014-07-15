(function() {
  this.LanguageLesson.module("LessonsApp.Create", function(Create, App, Backbone, Marionette, $, _) {
    return Create.Controller = {
      createLesson: function() {
        this.layout = this.getLayoutView();
        this.layout.on("show", (function(_this) {
          return function() {
            console.log('here?');
            _this.showPaletteRegion();
            _this.showArrangementRegion();
            return _this.showEditingRegion();
          };
        })(this));
        return App.mainRegion.show(this.layout);
      },
      getLayoutView: function() {
        return new Create.Layout;
      },
      showPaletteRegion: function() {
        return this.layout.paletteRegion.show(new Create.PaletteView);
      },
      showArrangementRegion: function() {
        return this.layout.arrangementRegion.show(new Create.ArrangementView);
      },
      showEditingRegion: function() {
        return this.layout.editingRegion.show(new Create.EditingView);
      }
    };
  });

}).call(this);
