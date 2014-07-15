(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonAttemptsApp.Review", function(Review, App, Backbone, Marionette, $, _) {
    return Review.Layout = (function(_super) {
      __extends(Layout, _super);

      function Layout() {
        return Layout.__super__.constructor.apply(this, arguments);
      }

      Layout.prototype.template = "lesson_attempts/review/templates/review_layout";

      Layout.prototype.regions = {
        contextRegion: "#context-region",
        infoRegion: "#info-region",
        questionAttemptsRegion: "#question-attempts-region",
        questionAttemptLayoutRegion: "#question-attempt-layout-region"
      };

      return Layout;

    })(App.Views.Layout);
  });

}).call(this);
