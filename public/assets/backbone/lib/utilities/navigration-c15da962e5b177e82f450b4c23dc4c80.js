(function() {
  this.LanguageLesson.module("Utilities", function(Utilities, App, Backbone, Marionette, $, _) {
    return _.extend(App, {
      navigate: function(route, options) {
        if (options == null) {
          options = {};
        }
        return Backbone.history.navigate(route, options);
      },
      getCurrentRoute: function() {
        var frag;
        frag = Backbone.history.fragment;
        if (_.isEmpty(frag)) {
          return null;
        } else {
          return frag;
        }
      },
      startHistory: function() {
        if (Backbone.history) {
          return Backbone.history.start();
        }
      }
    });
  });

}).call(this);
