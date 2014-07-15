(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonsApp", function(LessonsApp, App, Backbone, Marionette, $, _) {
    return LessonsApp.Router = (function(_super) {
      var API;

      __extends(Router, _super);

      function Router() {
        return Router.__super__.constructor.apply(this, arguments);
      }

      Router.prototype.appRoutes = {
        "lessons/new": "createLesson",
        "lessons/:id": "showLesson",
        "lessons/:id/attempt": "attemptLesson"
      };

      API = {
        showLesson: function(id) {
          var controller;
          controller = new LessonsApp.Show.Controller;
          return controller.showLesson(id);
        },
        createLesson: function() {
          return LessonsApp.Create.Controller.createLesson();
        },
        attemptLesson: function(id) {
          var controller;
          controller = new LessonsApp.Attempt.Controller;
          return controller.attemptLesson(id);
        }
      };

      App.addInitializer(function() {
        return new LessonsApp.Router({
          controller: API
        });
      });

      return Router;

    })(Marionette.AppRouter);
  });

}).call(this);
