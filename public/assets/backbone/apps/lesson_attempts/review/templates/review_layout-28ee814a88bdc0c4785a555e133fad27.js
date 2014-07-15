"use strict";

(function() { this.JST || (this.JST = {}); this.JST["backbone/apps/lesson_attempts/review/templates/review_layout"] = (function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='row'>\n  <div id='context-region'>CONTEXT</div>\n  <div id='info-region'></div>\n</div>\n<div class='row'>\n  <div id='question-attempts-region'></div>\n</div>\n<div class='row voffset2'>\n  <div id='question-attempt-layout-region'></div>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(window.HAML.context(context));
  });;
}).call(this);
