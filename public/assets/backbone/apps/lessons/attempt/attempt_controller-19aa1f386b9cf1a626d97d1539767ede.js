"use strict";

(function(window){

  var WORKER_PATH = '/assets/Recorderjs/recorderWorker.js';

  var Recorder = function(source, cfg){
    var config = cfg || {};
    var bufferLen = config.bufferLen || 4096;
    this.context = source.context;
    this.node = (this.context.createScriptProcessor ||
                 this.context.createJavaScriptNode).call(this.context,
                                                         bufferLen, 2, 2);
    var worker = new Worker(config.workerPath || WORKER_PATH);
    worker.postMessage({
      command: 'init',
      config: {
        sampleRate: this.context.sampleRate
      }
    });
    var recording = false,
      currCallback;

    this.node.onaudioprocess = function(e){
      if (!recording) return;
      worker.postMessage({
        command: 'record',
        buffer: [
          e.inputBuffer.getChannelData(0),
          e.inputBuffer.getChannelData(1)
        ]
      });
    }

    this.configure = function(cfg){
      for (var prop in cfg){
        if (cfg.hasOwnProperty(prop)){
          config[prop] = cfg[prop];
        }
      }
    }

    this.record = function(){
      recording = true;
    }

    this.stop = function(){
      recording = false;
    }

    this.clear = function(){
      worker.postMessage({ command: 'clear' });
    }

    this.getBuffer = function(cb) {
      currCallback = cb || config.callback;
      worker.postMessage({ command: 'getBuffer' })
    }

    this.exportWAV = function(cb, type){
      currCallback = cb || config.callback;
      type = type || config.type || 'audio/wav';
      if (!currCallback) throw new Error('Callback not set');
      worker.postMessage({
        command: 'exportWAV',
        type: type
      });
    }

    worker.onmessage = function(e){
      var blob = e.data;
      currCallback(blob);
    }

    source.connect(this.node);
    this.node.connect(this.context.destination);    //this should not be necessary
  };

  Recorder.forceDownload = function(blob, filename){
    var url = (window.URL || window.webkitURL).createObjectURL(blob);
    var link = window.document.createElement('a');
    link.href = url;
    link.download = filename || 'output.wav';
    var click = document.createEvent("Event");
    click.initEvent("click", true, true);
    link.dispatchEvent(click);
  }

  window.Recorder = Recorder;

})(window);
(function() {
  window.RecorderControls = {};

  RecorderControls.audio_context = null;

  RecorderControls.recorder = null;

  RecorderControls.analyser = null;

  RecorderControls.recording = false;

  RecorderControls.initialize = function() {
    var e;
    if (!RecorderControls.audio_context) {
      try {
        window.AudioContext = window.AudioContext || window.webkitAudioContext;
        navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;
        window.URL = window.URL || window.webkitURL;
        RecorderControls.audio_context = new AudioContext;
        console.log('Audio context set up.');
        console.log('navigator.getUserMedia ' + (navigator.getUserMedia ? 'available.' : 'not present!'));
      } catch (_error) {
        e = _error;
        alert('No web audio support in this browser!');
      }
      return navigator.getUserMedia({
        audio: true
      }, RecorderControls.startUserMedia, (function(_this) {
        return function(e) {
          return console.log('No live audio input: ' + e);
        };
      })(this));
    }
  };

  RecorderControls.startUserMedia = function(stream) {
    var e, zeroGain;
    try {
      Recorder.input = RecorderControls.audio_context.createMediaStreamSource(stream);
      console.log('Media stream created.');
    } catch (_error) {
      e = _error;
      alert(e);
    }
    zeroGain = RecorderControls.audio_context.createGain();
    zeroGain.gain.value = 0;
    Recorder.input.connect(zeroGain);
    zeroGain.connect(RecorderControls.audio_context.destination);
    console.log('Input connected to muted gain node connected to audio context destination.');
    RecorderControls.recorder = new Recorder(Recorder.input);
    return console.log('Recorder initialised.');
  };

  RecorderControls.startRecording = function() {
    RecorderControls.recording = true;
    RecorderControls.analyser = RecorderControls.audio_context.createAnalyser();
    RecorderControls.recorder && RecorderControls.recorder.record();
    return console.log('Recording...');
  };

  RecorderControls.stopRecording = function() {
    RecorderControls.recording = false;
    RecorderControls.recorder && RecorderControls.recorder.stop();
    return console.log('Stopped recording.');
  };

  RecorderControls.toggleRecording = function() {
    if (!RecorderControls.recording) {
      return RecorderControls.startRecording();
    } else {
      return RecorderControls.stopRecording();
    }
  };

  RecorderControls.upload = function() {
    RecorderControls.recorder && RecorderControls.recorder.exportWAV(function(blob) {
      var au, form, hf, li, oReq, url;
      url = URL.createObjectURL(blob);
      li = document.createElement('li');
      au = document.createElement('audio');
      hf = document.createElement('a');
      au.controls = true;
      au.src = url;
      hf.href = url;
      hf.download = new Date().toISOString() + '.wav';
      hf.innerHTML = hf.download;
      li.appendChild(au);
      li.appendChild(hf);
      console.log('Uploading file.');
      form = new FormData();
      form.append("recording[file]", blob);
      oReq = new XMLHttpRequest();
      oReq.open("POST", "http://languagelesson.local/recordings.json");
      oReq.send(form);
    });
  };

  RecorderControls.exportWAV = function(callback) {
    return RecorderControls.recorder && RecorderControls.recorder.exportWAV(function(blob) {
      return callback(blob);
    });
  };

  RecorderControls.clear = function() {
    return RecorderControls.recorder && RecorderControls.recorder.clear();
  };

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("LessonsApp.Attempt", function(Attempt, App, Backbone, Marionette, $, _) {
    return Attempt.Controller = (function(_super) {
      __extends(Controller, _super);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.initialize = function(options) {
        return App.vent.on('lesson:prevent_stepping_forward', function() {});
      };

      Controller.prototype.attemptLesson = function(lesson_id) {
        var currentUser;
        RecorderControls.initialize();
        currentUser = App.request("get:current:user");
        return App.request("lesson:entity", lesson_id, (function(_this) {
          return function(lesson) {
            return App.request("new:lesson_attempt:entity", lesson, currentUser, function(attempt) {
              _this.layout = _this.getLayoutView(attempt, currentUser);
              _this.layout.on("show", function() {
                _this.attemptLessonInfo(attempt.get('lesson'));
                return _this.attemptElements(attempt, currentUser);
              });
              return App.mainRegion.show(_this.layout);
            });
          };
        })(this));
      };

      Controller.prototype.attemptElements = function(attempt, currentUser) {
        var elementsView;
        elementsView = this.getElementsView(attempt, currentUser);
        return this.layout.elementsRegion.show(elementsView);
      };

      Controller.prototype.attemptLessonInfo = function(lesson) {
        var infoView;
        infoView = this.getInfoView(lesson);
        return this.layout.infoRegion.show(infoView);
      };

      Controller.prototype.getLayoutView = function(attempt, user) {
        return new Attempt.Layout({
          attempt: attempt,
          currentUser: user
        });
      };

      Controller.prototype.getInfoView = function(lesson) {
        return new Attempt.LessonInfo({
          model: lesson
        });
      };

      Controller.prototype.getElementsView = function(attempt, currentUser) {
        return new Attempt.Elements({
          model: attempt.get('lesson'),
          collection: attempt.get('lesson').elements,
          attempt: attempt,
          user: currentUser
        });
      };

      return Controller;

    })(App.Controllers.Application);
  });

}).call(this);
