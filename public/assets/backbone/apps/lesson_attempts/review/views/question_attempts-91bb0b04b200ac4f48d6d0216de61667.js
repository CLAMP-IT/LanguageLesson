(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonAttemptsApp.Review", function(Review, App, Backbone, Marionette, $, _) {
    return Review.QuestionAttempts = (function(_super) {
      __extends(QuestionAttempts, _super);

      function QuestionAttempts() {
        return QuestionAttempts.__super__.constructor.apply(this, arguments);
      }

      QuestionAttempts.prototype.template = "lesson_attempts/review/templates/_question_attempts";

      QuestionAttempts.prototype.childView = Review.QuestionAttemptButton;

      QuestionAttempts.prototype.childViewContainer = "#questions-list";

      return QuestionAttempts;

    })(App.Views.CompositeView);
  });

}).call(this);
