(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonsApp.Attempt", function(Attempt, App, Backbone, Marionette, $, _) {
    return Attempt.Element = (function(_super) {
      __extends(Element, _super);

      function Element() {
        return Element.__super__.constructor.apply(this, arguments);
      }

      Element.prototype.template = "lessons/attempt/templates/_bare_element";

      Element.prototype.tagName = 'div';

      return Element;

    })(App.Views.ItemView);
  });

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonsApp.Attempt", function(Attempt, App, Backbone, Marionette, $, _) {
    return Attempt.ContentBlockElement = (function(_super) {
      __extends(ContentBlockElement, _super);

      function ContentBlockElement() {
        return ContentBlockElement.__super__.constructor.apply(this, arguments);
      }

      ContentBlockElement.prototype.template = 'lessons/attempt/templates/_content_block';

      ContentBlockElement.prototype.onShow = function() {
        return App.vent.trigger("lesson:allow_stepping_forward");
      };

      return ContentBlockElement;

    })(Attempt.Element);
  });

}).call(this);
