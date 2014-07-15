"use strict";

(function() { this.JST || (this.JST = {}); this.JST["backbone/apps/lessons/create/templates/create_editing"] = (function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("editing stuff\nhi\n<br>\nhi\nhi\n<br>\nhi\n<br>\nhi\n<br>\nhi\n<br>\n<p>\n  <div class='editable' id='editor'>\n    Hello, edit me?\n  </div>\n</p>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(window.HAML.context(context));
  });;
}).call(this);
