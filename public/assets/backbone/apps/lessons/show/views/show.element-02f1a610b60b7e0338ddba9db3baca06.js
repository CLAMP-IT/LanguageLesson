(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonsApp.Show", function(Show, App, Backbone, Marionette, $, _) {
    return Show.Element = (function(_super) {
      __extends(Element, _super);

      function Element() {
        return Element.__super__.constructor.apply(this, arguments);
      }

      Element.prototype.template = "lessons/show/templates/_bare_element";

      Element.prototype.tagName = 'div';

      Element.prototype.events = {
        'click .prev': 'prev',
        'click .next': 'next'
      };

      Element.prototype.prev = function() {
        return App.trigger('lesson:previous_element', this.model);
      };

      Element.prototype.next = function() {
        return App.trigger('lesson:next_element', this.model);
      };

      return Element;

    })(App.Views.ItemView);
  });

}).call(this);
