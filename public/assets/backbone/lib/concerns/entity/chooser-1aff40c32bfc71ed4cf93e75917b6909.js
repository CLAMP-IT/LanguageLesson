(function() {
  this.LanguageLesson.module("Concerns", function(Concerns, App, Backbone, Marionette, $, _) {
    Concerns.Chooser = {
      initialize: function() {
        return new Backbone.Chooser(this);
      }
    };
    return Concerns.SingleChooser = {
      beforeIncluded: function(klass, concern) {
        return klass.prototype.model.include("Chooser");
      },
      initialize: function() {
        return new Backbone.SingleChooser(this);
      }
    };
  });

}).call(this);
