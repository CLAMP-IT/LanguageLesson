(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Controllers", function(Controllers, App, Backbone, Marionette, $, _) {
    return Controllers.Application = (function(_super) {
      __extends(Application, _super);

      function Application() {
        return Application.__super__.constructor.apply(this, arguments);
      }

      Application.prototype.close = function() {
        console.log("closing", this);
        App.execute("unregister:instance", this, this._instance_id);
        return Application.__super__.close.apply(this, arguments);
      };

      Application.prototype.show = function(view, options) {
        var _ref;
        if (options == null) {
          options = {};
        }
        _.defaults(options, {
          loading: false,
          region: this.region
        });
        view = view.getMainView ? view.getMainView() : view;
        if (!view) {
          throw new Error("getMainView() did not return a view instance or " + (view != null ? (_ref = view.constructor) != null ? _ref.name : void 0 : void 0) + " is not a view instance");
        }
        this.setMainView(view);
        return this._manageView(view, options);
      };

      Application.prototype.getMainView = function() {
        return this._mainView;
      };

      Application.prototype.setMainView = function(view) {
        if (this._mainView) {
          return;
        }
        this._mainView = view;
        return this.listenTo(view, "close", this.close);
      };

      Application.prototype._manageView = function(view, options) {
        if (options.loading) {
          return App.execute("show:loading", view, options);
        } else {
          return options.region.show(view);
        }
      };

      Application.prototype.mergeDefaultsInto = function(obj) {
        obj = _.isObject(obj) ? obj : {};
        return _.defaults(obj, this._getDefaults());
      };

      Application.prototype._getDefaults = function() {
        return _.clone(_.result(this, "defaults"));
      };

      return Application;

    })(Marionette.Controller);
  });

}).call(this);
