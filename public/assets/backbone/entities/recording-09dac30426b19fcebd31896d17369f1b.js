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
