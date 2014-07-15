(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.LanguageLesson.module("Entities", function(Entities, App, Backbone, Marionette, $, _) {
    return Entities.Model = (function(_super) {
      __extends(Model, _super);

      function Model() {
        return Model.__super__.constructor.apply(this, arguments);
      }

      Entities.AssociatedModel = (function(_super1) {
        __extends(AssociatedModel, _super1);

        function AssociatedModel() {
          return AssociatedModel.__super__.constructor.apply(this, arguments);
        }

        return AssociatedModel;

      })(Backbone.AssociatedModel);

      return Model;

    })(Backbone.Model);
  });

}).call(this);
