(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonAttemptsApp.List", function(List, App, Backbone, Marionette, $, _) {
    List.Layout = (function(_super) {
      __extends(Layout, _super);

      function Layout() {
        return Layout.__super__.constructor.apply(this, arguments);
      }

      Layout.prototype.template = "lesson_attempts/list/templates/list_layout";

      Layout.prototype.regions = {
        attemptsRegion: "#attempts-region"
      };

      return Layout;

    })(App.Views.Layout);
    List.LessonAttempt = (function(_super) {
      __extends(LessonAttempt, _super);

      function LessonAttempt() {
        return LessonAttempt.__super__.constructor.apply(this, arguments);
      }

      LessonAttempt.prototype.template = "lesson_attempts/list/templates/_lesson_attempt";

      LessonAttempt.prototype.tagName = "tr";

      LessonAttempt.prototype.modelEvents = {
        "updated": "render"
      };

      LessonAttempt.prototype.triggers = {
        "click [data-js-edit]": "edit:lesson_attempt:clicked"
      };

      return LessonAttempt;

    })(App.Views.ItemView);
    return List.LessonAttempts = (function(_super) {
      __extends(LessonAttempts, _super);

      function LessonAttempts() {
        return LessonAttempts.__super__.constructor.apply(this, arguments);
      }

      LessonAttempts.prototype.template = "lesson_attempts/list/templates/_lesson_attempts";

      LessonAttempts.prototype.childView = List.LessonAttempt;

      LessonAttempts.prototype.childViewContainer = "tbody";

      return LessonAttempts;

    })(App.Views.CompositeView);
  });

}).call(this);
