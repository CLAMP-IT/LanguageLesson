(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonsApp.Show", function(Show, App, Backbone, Marionette, $, _) {
    return Show.Controller = (function(_super) {
      __extends(Controller, _super);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.showLesson = function(id) {
        return App.request("lesson:entity", id, (function(_this) {
          return function(lesson) {
            _this.layout = _this.getLayoutView(lesson);
            _this.layout.on("show", function() {
              _this.showLessonInfo(lesson);
              return _this.showElements(lesson);
            });
            return App.mainRegion.show(_this.layout);
          };
        })(this));
      };

      Controller.prototype.showElements = function(lesson) {
        var elementsView;
        elementsView = this.getElementsView(lesson);
        return this.layout.elementsRegion.show(elementsView);
      };

      Controller.prototype.showLessonInfo = function(lesson) {
        var infoView;
        infoView = this.getInfoView(lesson);
        return this.layout.infoRegion.show(infoView);
      };

      Controller.prototype.getLayoutView = function() {
        return new Show.Layout;
      };

      Controller.prototype.getInfoView = function(lesson) {
        return new Show.LessonInfo({
          model: lesson
        });
      };

      Controller.prototype.getElementsView = function(lesson) {
        return new Show.Elements({
          model: lesson,
          collection: lesson.elements,
          foo: 'bar'
        });
      };

      return Controller;

    })(App.Controllers.Application);
  });

}).call(this);
