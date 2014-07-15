(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonAttemptsApp.Review", function(Review, App, Backbone, Marionette, $, _) {
    return Review.LessonAttemptInfo = (function(_super) {
      __extends(LessonAttemptInfo, _super);

      function LessonAttemptInfo() {
        return LessonAttemptInfo.__super__.constructor.apply(this, arguments);
      }

      LessonAttemptInfo.prototype.template = "lesson_attempts/review/templates/lesson_attempt_info";

      return LessonAttemptInfo;

    })(App.Views.ItemView);
  });

}).call(this);
