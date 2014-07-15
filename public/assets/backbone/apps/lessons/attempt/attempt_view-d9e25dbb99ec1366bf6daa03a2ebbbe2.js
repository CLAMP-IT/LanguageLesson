(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonsApp.Attempt", function(Attempt, App, Backbone, Marionette, $, _) {
    Attempt.LessonInfo = (function(_super) {
      __extends(LessonInfo, _super);

      function LessonInfo() {
        return LessonInfo.__super__.constructor.apply(this, arguments);
      }

      LessonInfo.prototype.template = "lessons/attempt/templates/lesson_info";

      return LessonInfo;

    })(App.Views.ItemView);
    return Attempt.Layout = (function(_super) {
      __extends(Layout, _super);

      function Layout() {
        return Layout.__super__.constructor.apply(this, arguments);
      }

      Layout.prototype.template = "lessons/attempt/templates/attempt_layout";

      Layout.prototype.initialize = function(options) {
        App.vent.on('lesson:prevent_stepping_forward', (function(_this) {
          return function() {
            console.log('preventing in the layout view');
            _this.preventSteppingForward();
          };
        })(this));
        return App.vent.on('lesson:allow_stepping_forward', (function(_this) {
          return function() {
            console.log('allowing in the layout view');
            _this.allowSteppingForward();
          };
        })(this));
      };

      Layout.prototype.stepForward = true;

      Layout.prototype.stepBackward = true;

      Layout.prototype.keys = {
        'left': 'prev',
        'right': 'next'
      };

      Layout.prototype.events = {
        'click .prev': 'prev',
        'click .next': 'next'
      };

      Layout.prototype.regions = {
        infoRegion: "#info-region",
        elementsRegion: "#elements-region"
      };

      Layout.prototype.preventSteppingForward = function() {
        return this.stepForward = false;
      };

      Layout.prototype.allowSteppingForward = function() {
        return this.stepForward = true;
      };

      Layout.prototype.preventSteppingBackward = function() {
        return this.stepBackward = false;
      };

      Layout.prototype.allowSteppingBackward = function() {
        return this.stepBackward = true;
      };

      Layout.prototype.next = function() {
        if (this.stepForward) {
          return App.trigger('lesson:next_element', this.model);
        }
      };

      Layout.prototype.prev = function() {
        if (this.stepBackward) {
          return App.trigger('lesson:previous_element', this.model);
        }
      };

      return Layout;

    })(App.Views.Layout);
  });

}).call(this);
