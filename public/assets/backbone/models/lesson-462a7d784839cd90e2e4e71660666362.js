(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  LanguageLesson.Models.Lesson = (function(_super) {
    __extends(Lesson, _super);

    function Lesson() {
      return Lesson.__super__.constructor.apply(this, arguments);
    }

    Lesson.prototype.paramRoot = 'lesson';

    return Lesson;

  })(Backbone.Model);

  LanguageLesson.Collections.LessonsCollection = (function(_super) {
    __extends(LessonsCollection, _super);

    function LessonsCollection() {
      return LessonsCollection.__super__.constructor.apply(this, arguments);
    }

    LessonsCollection.prototype.model = LanguageLesson.Models.Lesson;

    LessonsCollection.prototype.url = '/lessons';

    return LessonsCollection;

  })(Backbone.Collection);

}).call(this);
