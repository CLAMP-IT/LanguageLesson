(function() {
  this.LanguageLesson.module("Concerns", function(Concerns, App, Backbone, Marionette, $, _) {
    return Concerns.Chooseable = {
      modelEvents: {
        "change:chosen": "changeChosen"
      },
      changeChosen: function(model, value, options) {
        return this.$el.toggleClass("active", value);
      },
      onRender: function() {
        if (this.model.isChosen()) {
          return this.$el.addClass("active");
        }
      },
      choose: function(e) {
        e.preventDefault();
        return this.model.choose();
      },
      unchoose: function(e) {
        e.preventDefault();
        return this.model.unchoose();
      }
    };
  });

}).call(this);
