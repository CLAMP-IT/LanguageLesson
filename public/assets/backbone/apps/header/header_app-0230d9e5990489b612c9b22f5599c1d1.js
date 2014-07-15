(function() {
  this.LanguageLesson.module("HeaderApp", function(HeaderApp, App, Backbone, Marionette, $, _) {
    var API;
    this.startWithParent = false;
    API = {
      listHeader: function() {
        return HeaderApp.List.Controller.listHeader();
      }
    };
    return HeaderApp.on("start", function() {
      return API.listHeader();
    });
  });

}).call(this);
