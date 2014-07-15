(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonsApp.Show", function(Show, App, Backbone, Marionette, $, _) {
    return Show.Elements = (function(_super) {
      __extends(Elements, _super);

      function Elements() {
        return Elements.__super__.constructor.apply(this, arguments);
      }

      Elements.prototype.currentView = 0;

      Elements.prototype.template = "lessons/show/templates/elements_collection";

      Elements.prototype.regions = {
        elements: '#elements'
      };

      Elements.prototype.itemViewContainer = function() {
        return '#elements';
      };

      Elements.prototype.initialize = function(options) {
        _.bindAll(this, 'previousView', 'nextView', 'onRender', 'showElementView');
        LanguageLesson.on("lesson:previous_element", this.previousView);
        LanguageLesson.on("lesson:next_element", this.nextView);
        this.options = options || {};
      };

      Elements.prototype.onRender = function() {
        return this.showElementView();
      };

      Elements.prototype.nextView = function(element) {
        if (this.currentView < (this.model.elements.length - 1)) {
          $('.lesson_element').fadeOut(200, (function() {
            this.currentView += 1;
            this.showElementView();
            $("#element_count").html("" + (this.currentView + 1) + " of " + this.model.elements.length);
          }).bind(this));
        }
        return console.log(this.model.elements);
      };

      Elements.prototype.previousView = function(element) {
        if (this.currentView > 0) {
          return $('.lesson_element').fadeOut(200, (function() {
            this.currentView -= 1;
            this.showElementView();
            $("#element_count").html("" + (this.currentView + 1) + " of " + this.model.elements.length);
          }).bind(this));
        }
      };

      Elements.prototype.showElementView = function() {
        var element, model;
        model = this.model.elements.models[this.currentView];
        switch (model.attributes.type) {
          case 'PromptedAudioQuestion':
            element = new Show.PromptedAudioQuestionElement({
              model: this.model.elements.models[this.currentView]
            });
            break;
          case 'ContentBlock':
            element = new Show.ContentBlockElement({
              model: this.model.elements.models[this.currentView]
            });
        }
        return this.elements.show(element);
      };

      return Elements;

    })(App.Views.Layout);
  });

}).call(this);
