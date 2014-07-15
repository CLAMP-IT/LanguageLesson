(function() {
  this.LanguageLesson.module("Views", function(Views, App, Backbone, Marionette, $, _) {
    return _.extend(Marionette.View.prototype, {
      templateHelpers: function() {
        return {
          linkTo: function(name, url, options) {
            if (options == null) {
              options = {};
            }
            return _.defaults(options, {
              external: false
            });
          }
        };
      }
    });
  });

}).call(this);
