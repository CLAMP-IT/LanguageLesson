(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonAttemptsApp.Review", function(Review, App, Backbone, Marionette, $, _) {
    return Review.QuestionAttemptResponses = (function(_super) {
      __extends(QuestionAttemptResponses, _super);

      function QuestionAttemptResponses() {
        return QuestionAttemptResponses.__super__.constructor.apply(this, arguments);
      }

      QuestionAttemptResponses.prototype.childView = Review.QuestionAttemptResponse;

      QuestionAttemptResponses.prototype.modelEvents = {
        "updated": "render"
      };

      QuestionAttemptResponses.prototype.childEvents = {
        "render": function() {
          return console.log('a child has been rendered');
        },
        "destroy": function(view) {
          return console.log(this);
        }
      };

      return QuestionAttemptResponses;

    })(App.Views.CollectionView);
  });

}).call(this);
