(function() {
  this.LanguageLesson = (function(Backbone, Marionette) {
    var App;
    App = new Marionette.Application;
    App.addRegions({
      headerRegion: "#header-region",
      mainRegion: "#main-region",
      footerRegion: "#footer-region"
    });
    App.on("before:start", function(options) {
      return this.currentUser = App.request("set:current:user", options.currentUser);
    });
    App.reqres.setHandler("get:current:user", function() {
      return App.currentUser;
    });
    App.on("start", function() {
      this.addRegions({
        dialogRegion: {
          selector: "#dialog-region",
          regionType: App.Regions.Modal
        }
      });
      if (Backbone.history) {
        return Backbone.history.start();
      }
    });
    return App;
  })(Backbone, Marionette);

}).call(this);
