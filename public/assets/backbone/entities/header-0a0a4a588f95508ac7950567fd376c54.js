(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Entities", function(Entities, App, Backbone, Marionette, $, _) {
    var API;
    Entities.Header = (function(_super) {
      __extends(Header, _super);

      function Header() {
        return Header.__super__.constructor.apply(this, arguments);
      }

      return Header;

    })(Entities.Model);
    Entities.HeaderCollection = (function(_super) {
      __extends(HeaderCollection, _super);

      function HeaderCollection() {
        return HeaderCollection.__super__.constructor.apply(this, arguments);
      }

      HeaderCollection.prototype.model = Entities.Header;

      return HeaderCollection;

    })(Entities.Collection);
    API = {
      getHeaders: function() {
        return new Entities.HeaderCollection([
          {
            name: "Home"
          }, {
            name: "Lessons"
          }
        ]);
      }
    };
    return App.reqres.setHandler("header:entities", function() {
      return API.getHeaders();
    });
  });

}).call(this);
