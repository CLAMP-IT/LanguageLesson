(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonsApp.Create", function(Create, App, Backbone, Marionette, $, _) {
    return Create.Layout = (function(_super) {
      __extends(Layout, _super);

      function Layout() {
        return Layout.__super__.constructor.apply(this, arguments);
      }

      Layout.prototype.template = "lessons/create/templates/create_layout";

      Layout.prototype.regions = {
        paletteRegion: "#palette-region",
        arrangementRegion: "#arrangement-region",
        editingRegion: "#editing-region"
      };

      return Layout;

    })(App.Views.Layout);
  });

}).call(this);
