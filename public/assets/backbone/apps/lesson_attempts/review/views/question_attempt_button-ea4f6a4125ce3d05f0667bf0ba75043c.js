(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonAttemptsApp.Review", function(Review, App, Backbone, Marionette, $, _) {
    return Review.QuestionAttemptButton = (function(_super) {
      __extends(QuestionAttemptButton, _super);

      function QuestionAttemptButton() {
        this.className = __bind(this.className, this);
        return QuestionAttemptButton.__super__.constructor.apply(this, arguments);
      }

      QuestionAttemptButton.prototype.template = "lesson_attempts/review/templates/_question_attempt_button";

      QuestionAttemptButton.prototype.tagName = "li";

      QuestionAttemptButton.prototype.className = function() {
        if (!this.model.responded) {
          return 'responded';
        }
      };

      QuestionAttemptButton.prototype.modelEvents = {
        "updated": "render"
      };

      QuestionAttemptButton.prototype.triggers = {
        "click [data-js-respond]": "respond:question_attempt:clicked",
        "click": "respond:question_attempt:clicked"
      };

      return QuestionAttemptButton;

    })(App.Views.ItemView);
  });

}).call(this);
