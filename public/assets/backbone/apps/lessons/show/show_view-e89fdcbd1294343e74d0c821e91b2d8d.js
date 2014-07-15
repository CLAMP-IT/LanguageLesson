(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonsApp.Show", function(Show, App, Backbone, Marionette, $, _) {
    Show.LessonInfo = (function(_super) {
      __extends(LessonInfo, _super);

      function LessonInfo() {
        return LessonInfo.__super__.constructor.apply(this, arguments);
      }

      LessonInfo.prototype.template = "lessons/show/templates/lesson_info";

      return LessonInfo;

    })(App.Views.ItemView);
    return Show.Layout = (function(_super) {
      __extends(Layout, _super);

      function Layout() {
        return Layout.__super__.constructor.apply(this, arguments);
      }

      Layout.prototype.template = "lessons/show/templates/show_layout";

      Layout.prototype.keys = {
        'left': 'prev',
        'right': 'next'
      };

      Layout.prototype.regions = {
        infoRegion: "#info-region",
        elementsRegion: "#elements-region"
      };

      Layout.prototype.prev = function() {
        return App.trigger('lesson:previous_element', this.model);
      };

      Layout.prototype.next = function() {
        return App.trigger('lesson:next_element', this.model);
      };

      return Layout;

    })(App.Views.Layout);
  });

}).call(this);
