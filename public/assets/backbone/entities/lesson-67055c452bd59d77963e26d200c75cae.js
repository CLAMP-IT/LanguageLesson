(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Entities", function(Entities, App, Backbone, Marionette, $, _) {
    var API;
    Entities.LessonElement = (function(_super) {
      __extends(LessonElement, _super);

      function LessonElement() {
        return LessonElement.__super__.constructor.apply(this, arguments);
      }

      return LessonElement;

    })(Entities.AssociatedModel);
    Entities.LessonElements = (function(_super) {
      __extends(LessonElements, _super);

      function LessonElements() {
        return LessonElements.__super__.constructor.apply(this, arguments);
      }

      LessonElements.prototype.model = Entities.LessonElement;

      return LessonElements;

    })(Entities.Collection);
    Entities.Lesson = (function(_super) {
      __extends(Lesson, _super);

      function Lesson() {
        return Lesson.__super__.constructor.apply(this, arguments);
      }

      Lesson.prototype.urlRoot = function() {
        return Routes.lessons_path();
      };

      Lesson.prototype.rubyClass = 'Lesson';

      return Lesson;

    })(Entities.AssociatedModel);
    API = {
      getLessonEntity: function(id, cb) {
        var lesson;
        lesson = new Entities.Lesson({
          id: id
        });
        lesson.fetch({
          reset: true,
          success: function(model, response) {
            lesson.elements = new Entities.LessonElements(lesson.attributes.page_elements);
            return cb(lesson);
          }
        });
        return lesson;
      }
    };
    return App.reqres.setHandler("lesson:entity", function(id, cb) {
      return API.getLessonEntity(id, cb);
    });
  });

}).call(this);
