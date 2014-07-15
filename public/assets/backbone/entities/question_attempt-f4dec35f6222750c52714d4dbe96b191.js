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
