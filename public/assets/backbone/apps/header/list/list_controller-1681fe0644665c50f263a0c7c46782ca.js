(function() {
  this.LanguageLesson.module("HeaderApp.List", function(List, App, Backbone, Marionette, $, _) {
    return List.Controller = {
      listHeader: function() {
        var headerView, links;
        links = App.request("header:entities");
        headerView = this.getHeaderView(links);
        return App.headerRegion.show(headerView);
      },
      getHeaderView: function(links) {
        return new List.Headers({
          collection: links
        });
      }
    };
  });

}).call(this);
