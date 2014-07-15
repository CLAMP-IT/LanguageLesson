(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Entities", function(Entities, App, Backbone, Marionette, $, _) {
    Entities.Question = (function(_super) {
      __extends(Question, _super);

      function Question() {
        return Question.__super__.constructor.apply(this, arguments);
      }

      Question.prototype.urlRoot = function() {
        return Routes.questions_path();
      };

      return Question;

    })(Entities.AssociatedModel);
    return Entities.QuestionAttempts = (function(_super) {
      __extends(QuestionAttempts, _super);

      function QuestionAttempts() {
        return QuestionAttempts.__super__.constructor.apply(this, arguments);
      }

      QuestionAttempts.prototype.model = Entities.QuestionAttempt;

      return QuestionAttempts;

    })(Entities.Collection);
  });

}).call(this);
