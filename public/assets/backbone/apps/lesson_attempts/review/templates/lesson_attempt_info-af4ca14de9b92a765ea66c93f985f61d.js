"use strict";

(function() { this.JST || (this.JST = {}); this.JST["backbone/apps/lesson_attempts/review/templates/lesson_attempt_info"] = (function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='lesson_name'>\n  <b>Lesson name: " + this.lesson.name + "</b>\n</div>\n<div class='user_name'>\n  <b>User name: " + this.user.name + "</b>\n</div>\n<div class='question_attempts_count'>\n  <b>Number of questions attempted: " + this.question_attempts.length + "</b>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(window.HAML.context(context));
  });;
}).call(this);
