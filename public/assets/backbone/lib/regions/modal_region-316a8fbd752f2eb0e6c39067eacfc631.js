(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Regions", function(Regions, App, Backbone, Marionette, $, _) {
    return Regions.Modal = (function(_super) {
      __extends(Modal, _super);

      function Modal() {
        Marionette.Region.prototype.constructor.apply(this, arguments);
        this.ensureEl();
        this.$el.on('hidden', {
          region: this
        }, function(event) {
          return event.data.region.close();
        });
      }

      Modal.prototype.onShow = function() {
        return $('#dialog').modal('show');
      };

      Modal.prototype.onDestroy = function() {
        return this.$el.modal('hide');
      };

      return Modal;

    })(Marionette.Region);
  });

}).call(this);
