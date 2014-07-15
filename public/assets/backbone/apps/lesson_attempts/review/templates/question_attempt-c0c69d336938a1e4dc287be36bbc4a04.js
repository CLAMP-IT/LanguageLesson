"use strict";

(function() { this.JST || (this.JST = {}); this.JST["backbone/apps/lesson_attempts/review/templates/question_attempt"] = (function(context) {
    return (function() {
      var $c, $e, $o;
      $e = window.HAML.escape;
      $c = window.HAML.cleanValue;
      $o = [];
      $o.push("<div class='PromptedAudioQuestion lesson_element'>\n  <div class='title'>\n    <h4>" + ($e($c(this.question.title))) + "</h4>\n  </div>\n  <div id='element-content'>" + this.question.content + "</div>\n  <div id='recording'>\n    <div class='response_wave'></div>\n    <div class='controls voffset2'>\n      <button class='btn' data-action='back'>\n        <i class='icon icon-step-backward'></i>\n        Seek Backward\n      </button>\n      <button class='btn' data-action='play'>\n        <i class='icon icon-play'></i>\n        Play /\n        <i class='icon icon-pause'></i>\n        Pause\n      </button>\n      <button class='btn' data-action='forth'>\n        <i class='icon icon-step-forward'></i>\n        Seek Forward\n      </button>\n    </div>\n    <div class='voffset2'>\n      Select a region of the waveform to leave a comment.\n    </div>\n    <div class='voffset2'>\n      <ul id='responses'></ul>\n    </div>\n  </div>\n</div>");
      return $o.join("\n").replace(/\s([\w-]+)='true'/mg, ' $1').replace(/\s([\w-]+)='false'/mg, '').replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(window.HAML.context(context));
  });;
}).call(this);
