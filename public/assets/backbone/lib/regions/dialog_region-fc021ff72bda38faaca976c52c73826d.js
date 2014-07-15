(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Regions", function(Regions, App, Backbone, Marionette, $, _) {
    return Regions.Dialog = (function(_super) {
      __extends(Dialog, _super);

      function Dialog() {
        return Dialog.__super__.constructor.apply(this, arguments);
      }

      Dialog.prototype.onShow = function(view) {
        $('#dualog').modal();
        return $('#dualog').modal('show');
      };

      Dialog.prototype.setupBindings = function(view) {
        return this.listenTo(view, "dialog:close", this.close);
      };

      Dialog.prototype.getDefaultOptions = function(options) {
        var _ref;
        if (options == null) {
          options = {};
        }
        return _.defaults(options, {
          title: "default title",
          dialogClass: (_ref = options.className) != null ? _ref : "",
          size: "small"
        });
      };

      Dialog.prototype.openDialog = function(options) {
        return this.$el.on("closed", (function(_this) {
          return function() {
            return _this.close();
          };
        })(this));
      };

      Dialog.prototype.getTitle = function(options) {
        return _.result(options, "title");
      };

      Dialog.prototype.onDestroy = function() {
        this.$el.off("closed");
        this.stopListening();
        return this.$el.foundation("reveal", "close");
      };

      return Dialog;

    })(Marionette.Region);
  });

}).call(this);
