(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonAttemptsApp", function(LessonAttemptsApp, App, Backbone, Marionette, $, _) {
    var API;
    LessonAttemptsApp.Router = (function(_super) {
      __extends(Router, _super);

      function Router() {
        return Router.__super__.constructor.apply(this, arguments);
      }

      Router.prototype.appRoutes = {
        "lesson_attempts": "list",
        "lesson_attempts/:id": "show",
        "lesson_attempts/:id/review": "review"
      };

      return Router;

    })(Marionette.AppRouter);
    API = {
      list: function() {
        var controller;
        controller = new LessonAttemptsApp.List.Controller;
        return controller.listLessonAttempts();
      },
      show: function(id) {
        var controller;
        controller = new LessonAttemptsApp.Show.Controller;
        return controller.showLessonAttempt(id);
      },
      review: function(id) {
        var controller;
        controller = new LessonAttemptsApp.Review.Controller;
        return controller.review(id);
      },
      reviewQuestionAttempt: function(question_attempt) {
        var controller;
        controller = new LessonAttemptsApp.ReviewQuestionAttempt.Controller;
        return controller.review(question_attempt);
      }
    };
    App.addInitializer(function() {
      return new LessonAttemptsApp.Router({
        controller: API
      });
    });
    App.vent.on("edit:lesson_attempt:clicked", function(lesson_attempt) {
      App.navigate("lesson_attempts/" + lesson_attempt.attributes.id + "/review");
      return API.review(lesson_attempt.get('id'));
    });
    return App.vent.on("respond:question_attempt:clicked", function(question_attempt) {
      return API.reviewQuestionAttempt(question_attempt);
    });
  });

}).call(this);
