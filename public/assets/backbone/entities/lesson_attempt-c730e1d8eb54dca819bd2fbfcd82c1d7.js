(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Entities", function(Entities, App, Backbone, Marionette, $, _) {
    var API;
    Entities.User = (function(_super) {
      __extends(User, _super);

      function User() {
        return User.__super__.constructor.apply(this, arguments);
      }

      return User;

    })(Entities.AssociatedModel);
    Entities.UsersCollection = (function(_super) {
      __extends(UsersCollection, _super);

      function UsersCollection() {
        return UsersCollection.__super__.constructor.apply(this, arguments);
      }

      UsersCollection.prototype.model = Entities.User;

      UsersCollection.prototype.url = function() {
        return Routes.users_path();
      };

      return UsersCollection;

    })(Entities.Collection);
    API = {
      setCurrentUser: function(currentUser) {
        return new Entities.User(currentUser);
      },
      getUserEntities: function(cb) {
        var users;
        users = new Entities.UsersCollection;
        return users.fetch({
          success: function() {
            return cb(users);
          }
        });
      }
    };
    App.reqres.setHandler("set:current:user", function(currentUser) {
      return API.setCurrentUser(currentUser);
    });
    return App.reqres.setHandler("user:entities", function(cb) {
      return API.getUserEntities(cb);
    });
  });

}).call(this);
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
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Entities", function(Entities, App, Backbone, Marionette, $, _) {
    Entities.Question = (function(_super) {
      __extends(Question, _super);

      function Question() {
        return Question.__super__.constructor.apply(this, arguments);
      }

      Question.prototype.urlRoot = function() {
        return Routes.questions_path();
      };

      return Question;

    })(Entities.AssociatedModel);
    return Entities.QuestionAttempts = (function(_super) {
      __extends(QuestionAttempts, _super);

      function QuestionAttempts() {
        return QuestionAttempts.__super__.constructor.apply(this, arguments);
      }

      QuestionAttempts.prototype.model = Entities.QuestionAttempt;

      return QuestionAttempts;

    })(Entities.Collection);
  });

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Entities", function(Entities, App, Backbone, Marionette, $, _) {
    var API;
    Entities.Recording = (function(_super) {
      __extends(Recording, _super);

      function Recording() {
        return Recording.__super__.constructor.apply(this, arguments);
      }

      Recording.prototype.urlRoot = function() {
        return Routes.recordings_path();
      };

      Recording.prototype.saveRecording = function() {
        var form, oReq, postUrl;
        this.set('recordable_type', this.parents[0].rubyClass);
        this.set('recordable_id', this.parents[0].get('id'));
        console.log(this);
        form = new FormData();
        form.append("[recording][file]", this.get('blob'), 'recording.wav');
        form.append("[recording][recordable_type]", this.get('recordable_type'));
        form.append("[recording][recordable_id]", this.get('recordable_id'));
        postUrl = '/recordings';
        oReq = new XMLHttpRequest();
        oReq.open("POST", postUrl);
        return oReq.send(form);
      };

      return Recording;

    })(Entities.AssociatedModel);
    API = {
      createRecording: function() {
        return new Entities.Recording;
      }
    };
    return App.reqres.setHandler("create:recording:entity", function() {
      return API.createRecording();
    });
  });

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Entities", function(Entities, App, Backbone, Marionette, $, _) {
    var API;
    Entities.QuestionAttemptResponse = (function(_super) {
      __extends(QuestionAttemptResponse, _super);

      function QuestionAttemptResponse() {
        return QuestionAttemptResponse.__super__.constructor.apply(this, arguments);
      }

      QuestionAttemptResponse.prototype.rubyClass = 'QuestionAttemptResponse';

      QuestionAttemptResponse.prototype.relations = [
        {
          type: Backbone.One,
          key: 'recording',
          relatedModel: Entities.Recording
        }
      ];

      QuestionAttemptResponse.prototype.defaults = {
        recording: null
      };

      QuestionAttemptResponse.prototype.initialize = function() {
        var recording;
        this.rubyClass = 'QuestionAttemptResponse';
        recording = this.get('recording');
        this.listenTo(this, 'change:recording', function(model) {
          return model.get('recording').saveRecording();
        });
        return this.listenTo(this, 'change:note', function(model) {
          return model.save();
        });
      };

      return QuestionAttemptResponse;

    })(Entities.AssociatedModel);
    Entities.QuestionAttemptResponses = (function(_super) {
      __extends(QuestionAttemptResponses, _super);

      function QuestionAttemptResponses() {
        return QuestionAttemptResponses.__super__.constructor.apply(this, arguments);
      }

      QuestionAttemptResponses.prototype.model = Entities.QuestionAttemptResponse;

      return QuestionAttemptResponses;

    })(Entities.Collection);
    API = {
      createQuestionAttemptResponse: function(question_attempt) {
        var response;
        response = new Entities.QuestionAttemptResponse({
          question_attempt_id: question_attempt.get('id')
        });
        return response;
      }
    };
    return App.reqres.setHandler("create:question_attempt_response:entity", function(question_attempt) {
      return API.createQuestionAttemptResponse(question_attempt);
    });
  });

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Entities", function(Entities, App, Backbone, Marionette, $, _) {
    var API;
    Entities.QuestionAttempt = (function(_super) {
      __extends(QuestionAttempt, _super);

      function QuestionAttempt() {
        return QuestionAttempt.__super__.constructor.apply(this, arguments);
      }

      QuestionAttempt.prototype.urlRoot = function() {
        return Routes.question_attempts_path();
      };

      QuestionAttempt.prototype.rubyClass = 'QuestionAttempt';

      QuestionAttempt.prototype.relations = [
        {
          type: Backbone.Many,
          key: 'responses',
          collectionType: Entities.QuestionAttemptResponses
        }
      ];

      QuestionAttempt.prototype.defaults = {
        user: null,
        lesson: null,
        responses: []
      };

      QuestionAttempt.prototype.initialize = function(options) {
        var responses;
        options || (options = {});
        responses = this.get('responses');
        responses.url = (function(_this) {
          return function() {
            return "/question_attempts/" + _this.id + "/question_attempt_responses";
          };
        })(this);
        this.listenTo(responses, "add", function(model) {
          return model.save(null, {
            success: function(model, response) {
              console.log('success!');
              console.log(model);
              return console.log(response);
            },
            error: function() {
              return console.log('err-or');
            }
          });
        });
        this.listenTo(responses, "destroy", function(model) {
          return model.destroy();
        });
        return this.listenTo(responses, "change:", function(model) {});
      };

      return QuestionAttempt;

    })(Entities.AssociatedModel);
    Entities.QuestionAttempts = (function(_super) {
      __extends(QuestionAttempts, _super);

      function QuestionAttempts() {
        return QuestionAttempts.__super__.constructor.apply(this, arguments);
      }

      QuestionAttempts.prototype.model = Entities.QuestionAttempt;

      return QuestionAttempts;

    })(Entities.Collection);
    API = {
      findQuestionAttemptEntity: function(lesson_attempt_id, question_id, user_id, cb) {
        var questionAttempt;
        questionAttempt = new Entities.QuestionAttempt;
        questionAttempt.fetch({
          url: Routes.find_question_attempt_by_lesson_attempt_question_and_user_path(lesson_attempt_id, question_id, user_id),
          success: function(model, response) {
            return cb(questionAttempt);
          }
        });
        return questionAttempt;
      }
    };
    return App.reqres.setHandler("find:question_attempt:entity", function(lesson_attempt_id, question_id, user_id, cb) {
      return API.findQuestionAttemptEntity(lesson_attempt_id, question_id, user_id, cb);
    });
  });

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Entities", function(Entities, App, Backbone, Marionette, $, _) {
    var API;
    Entities.LessonAttempt = (function(_super) {
      __extends(LessonAttempt, _super);

      function LessonAttempt() {
        return LessonAttempt.__super__.constructor.apply(this, arguments);
      }

      LessonAttempt.prototype.urlRoot = function() {
        return Routes.lesson_attempts_path();
      };

      LessonAttempt.prototype.rubyClass = 'LessonAttempt';

      LessonAttempt.prototype.initialize = function() {
        var question_attempts;
        question_attempts = this.get('question_attempts');
        return question_attempts.url = (function(_this) {
          return function() {
            return "/lesson_attempts/" + _this.id + "/question_attempts";
          };
        })(this);
      };

      LessonAttempt.prototype.relations = [
        {
          type: Backbone.One,
          key: 'user',
          relatedModel: Entities.User
        }, {
          type: Backbone.One,
          key: 'lesson',
          relatedModel: Entities.Lesson
        }, {
          type: Backbone.One,
          key: 'question',
          relatedModel: Entities.Question
        }, {
          type: Backbone.Many,
          key: 'question_attempts',
          collectionType: Entities.QuestionAttempts
        }
      ];

      LessonAttempt.prototype.defaults = {
        user: null,
        lesson: null,
        question_attempts: []
      };

      return LessonAttempt;

    })(Entities.AssociatedModel);
    Entities.LessonAttemptsCollection = (function(_super) {
      __extends(LessonAttemptsCollection, _super);

      function LessonAttemptsCollection() {
        return LessonAttemptsCollection.__super__.constructor.apply(this, arguments);
      }

      LessonAttemptsCollection.prototype.model = Entities.LessonAttempt;

      LessonAttemptsCollection.prototype.url = function() {
        return Routes.lesson_attempts_path();
      };

      return LessonAttemptsCollection;

    })(Entities.Collection);
    API = {
      getLessonAttemptEntity: function(id, cb) {
        var lessonAttempt;
        lessonAttempt = new Entities.LessonAttempt({
          id: id
        });
        lessonAttempt.fetch({
          reset: true,
          success: function(model, response) {
            return cb(lessonAttempt);
          }
        });
        return lessonAttempt;
      },
      getLessonAttemptEntities: function(cb) {
        var lesson_attempts;
        lesson_attempts = new Entities.LessonAttemptsCollection;
        return lesson_attempts.fetch({
          success: function() {
            return cb(lesson_attempts);
          }
        });
      },
      newLessonAttemptEntity: function(lesson, user, cb) {
        var lessonAttempt;
        lessonAttempt = new Entities.LessonAttempt({
          lesson: lesson,
          user: user
        });
        lessonAttempt.save();
        return cb(lessonAttempt);
      }
    };
    App.reqres.setHandler("lesson_attempt:entity", function(id, cb) {
      return API.getLessonAttemptEntity(id, cb);
    });
    App.reqres.setHandler("lesson_attempt:entities", function(cb) {
      return API.getLessonAttemptEntities(cb);
    });
    return App.reqres.setHandler("new:lesson_attempt:entity", function(lesson, user, cb) {
      return API.newLessonAttemptEntity(lesson, user, cb);
    });
  });

}).call(this);
