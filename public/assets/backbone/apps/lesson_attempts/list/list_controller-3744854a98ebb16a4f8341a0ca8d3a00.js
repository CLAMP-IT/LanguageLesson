(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonAttemptsApp.List", function(List, App, Backbone, Marionette, $, _) {
    return List.Controller = (function(_super) {
      __extends(Controller, _super);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.listLessonAttempts = function() {
        return App.request("lesson_attempt:entities", (function(_this) {
          return function(lesson_attempts) {
            console.log(lesson_attempts);
            _this.layout = _this.getLayoutView();
            _this.layout.on("show", function() {
              return _this.showAttemptsRegion(lesson_attempts);
            });
            return App.mainRegion.show(_this.layout);
          };
        })(this));
      };

      Controller.prototype.getLayoutView = function() {
        return new List.Layout;
      };

      Controller.prototype.getListView = function(lesson_attempts) {
        return new List.LessonAttempts({
          collection: lesson_attempts
        });
      };

      Controller.prototype.showAttemptsRegion = function(lesson_attempts) {
        var listView;
        listView = this.getListView(lesson_attempts);
        console.log(this.layout);
        this.listenTo(listView, "childview:edit:lesson_attempt:clicked", function(iv, args) {
          console.log(args);
          return App.vent.trigger("edit:lesson_attempt:clicked", args.model);
        });
        return this.layout.attemptsRegion.show(listView);
      };

      return Controller;

    })(App.Controllers.Application);
  });

}).call(this);
