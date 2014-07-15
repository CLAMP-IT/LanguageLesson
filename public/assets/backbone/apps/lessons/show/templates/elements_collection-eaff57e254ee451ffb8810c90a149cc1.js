"use strict";

(function() { this.JST || (this.JST = {}); this.JST["backbone/apps/lessons/show/templates/elements_collection"] = (function(context) {
    return (function() {
      var $o;
      $o = [];
      console.log(this);
      $o.push("<div id='elements_counter'>\n  <h4 id='element_count'>1 of " + this.page_elements.length + "</h4>\n</div>\n<div id='elements'></div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(window.HAML.context(context));
  });;
}).call(this);
