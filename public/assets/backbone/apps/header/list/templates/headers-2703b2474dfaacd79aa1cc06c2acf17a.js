"use strict";

(function() { this.JST || (this.JST = {}); this.JST["backbone/apps/header/list/templates/headers"] = (function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='navbar' id='header'>\n  <div class='navbar-inner'>\n    <div class='container'>\n      <div class='row'>\n        <div class='pull-left'>\n          <span class='brand'>Language Lesson w/ Backbone</span>\n        </div>\n        <ul class='nav pull-right'></ul>\n      </div>\n    </div>\n  </div>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(window.HAML.context(context));
  });;
}).call(this);
