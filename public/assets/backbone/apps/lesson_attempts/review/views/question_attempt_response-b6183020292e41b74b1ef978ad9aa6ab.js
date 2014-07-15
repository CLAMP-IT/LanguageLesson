(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonAttemptsApp.Review", function(Review, App, Backbone, Marionette, $, _) {
    return Review.QuestionAttemptResponse = (function(_super) {
      __extends(QuestionAttemptResponse, _super);

      function QuestionAttemptResponse() {
        return QuestionAttemptResponse.__super__.constructor.apply(this, arguments);
      }

      QuestionAttemptResponse.prototype.template = "lesson_attempts/review/templates/_question_attempt_response";

      QuestionAttemptResponse.prototype.className = 'responseBox';

      QuestionAttemptResponse.prototype.initialize = function(options) {
        this.recording = null;
        return _.bindAll(this, 'hasRecording', 'getRecording', 'playRecording', 'showRecording', 'removeRecording', 'enablePlayButton', 'disablePlayButton');
      };

      QuestionAttemptResponse.prototype.events = {
        "click .js-record-toggle": "toggleRecording",
        "click .js-record-play": "playRecording",
        "click .js-record-remove": "removeRecording",
        "change .note_field": function() {
          this.model.set('note', this.$('.note_field').val());
          return console.log(this.model);
        }
      };

      QuestionAttemptResponse.prototype.triggers = {
        "mouseenter .responseForm": "question_attempt_response:selected"
      };

      QuestionAttemptResponse.prototype.onShow = function() {
        return console.log('onShow');
      };

      QuestionAttemptResponse.prototype.onRender = function() {
        console.log(this.model);
        this.$('[data-toggle=tooltip]').tooltip({
          container: 'body'
        });
        if (this.model.attributes['recording']) {
          return this.showRecording();
        }
      };

      QuestionAttemptResponse.prototype.onDestroy = function() {
        console.log(this);
        return App.trigger('question_attempt_response:closing', this.model);
      };

      QuestionAttemptResponse.prototype.modelEvents = {
        "updated": "render"
      };

      QuestionAttemptResponse.prototype.showRecording = function() {
        console.log("showing recording");
        console.log(this.model.get('recording'));
        this.$("#response-recording-audio").attr('src', this.model.get('recording.url'));
        return this.enablePlayButton();
      };

      QuestionAttemptResponse.prototype.hasRecording = function() {
        return this.$("#response-recording-audio").attr('src') !== null;
      };

      QuestionAttemptResponse.prototype.getRecording = function() {
        if (this.hasRecording) {
          return this.$("#response-recording-audio").attr('src');
        } else {
          return null;
        }
      };

      QuestionAttemptResponse.prototype.playRecording = function() {
        return this.$("#response-recording-audio").trigger('play');
      };

      QuestionAttemptResponse.prototype.removeRecording = function() {
        this.$('[data-toggle=tooltip]').tooltip('hide');
        this.trigger("response:remove", this.model);
        this.model.destroy();
        return this.destroy();
      };

      QuestionAttemptResponse.prototype.enablePlayButton = function() {
        this.$('.js-record-play').prop('disabled', false);
      };

      QuestionAttemptResponse.prototype.disablePlayButton = function() {
        this.$('.js-record-play').prop('disabled', true);
      };

      QuestionAttemptResponse.prototype.toggleRecording = function(event) {
        RecorderControls.toggleRecording();
        if (RecorderControls.recording) {
          $(event.currentTarget).addClass('btn-danger');
          return this.disablePlayButton();
        } else {
          $(event.currentTarget).removeClass('btn-danger');
          return RecorderControls.exportWAV((function(_this) {
            return function(blob) {
              var recording;
              _this.recording_url = URL.createObjectURL(blob);
              recording = App.request("create:recording:entity");
              recording.set('blob', blob);
              recording.set('url', _this.recording_url);
              _this.model.set('recording', recording);
              console.log(_this.model);
              _this.showRecording();
              return RecorderControls.clear();
            };
          })(this));
        }
      };

      QuestionAttemptResponse.prototype.onShow = function() {};

      return QuestionAttemptResponse;

    })(App.Views.ItemView);
  });

}).call(this);
