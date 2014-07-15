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
