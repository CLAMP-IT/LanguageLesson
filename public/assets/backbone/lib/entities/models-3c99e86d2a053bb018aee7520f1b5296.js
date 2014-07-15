(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Entities", function(Entities, App, Backbone, Marionette, $, _) {
    var API;
    Entities.Model = (function(_super) {
      __extends(Model, _super);

      function Model() {
        this.saveError = __bind(this.saveError, this);
        this.saveSuccess = __bind(this.saveSuccess, this);
        return Model.__super__.constructor.apply(this, arguments);
      }

      Model.prototype.destroy = function(options) {
        if (options == null) {
          options = {};
        }
        _.defaults(options, {
          wait: true
        });
        this.set({
          _destroy: true
        });
        return Model.__super__.destroy.call(this, options);
      };

      Model.prototype.isDestroyed = function() {
        return this.get("_destroy");
      };

      Model.prototype.save = function(data, options) {
        var isNew;
        if (options == null) {
          options = {};
        }
        isNew = this.isNew();
        _.defaults(options, {
          wait: true,
          success: _.bind(this.saveSuccess, this, isNew, options.collection, options.callback),
          error: _.bind(this.saveError, this)
        });
        this.unset("_errors");
        return Model.__super__.save.call(this, data, options);
      };

      Model.prototype.saveSuccess = function(isNew, collection, callback) {
        if (isNew) {
          if (collection != null) {
            collection.add(this);
          }
          if (collection != null) {
            collection.trigger("model:created", this);
          }
          this.trigger("created", this);
        } else {
          if (collection == null) {
            collection = this.collection;
          }
          if (collection != null) {
            collection.trigger("model:updated", this);
          }
          this.trigger("updated", this);
        }
        return typeof callback === "function" ? callback() : void 0;
      };

      Model.prototype.saveError = function(model, xhr, options) {
        var _ref;
        if (!/500|404/.test(xhr.status)) {
          return this.set({
            _errors: (_ref = $.parseJSON(xhr.responseText)) != null ? _ref.errors : void 0
          });
        }
      };

      return Model;

    })(Backbone.Model);
    API = {
      newModel: function(attrs) {
        return new Entities.Model(attrs);
      }
    };
    return App.reqres.setHandler("new:model", function(attrs) {
      if (attrs == null) {
        attrs = {};
      }
      return API.newModel(attrs);
    });
  });

}).call(this);
