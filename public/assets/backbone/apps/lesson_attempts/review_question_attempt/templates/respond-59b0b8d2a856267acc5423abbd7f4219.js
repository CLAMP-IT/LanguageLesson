"use strict";

(function() { this.JST || (this.JST = {}); this.JST["backbone/apps/lesson_attempts/review_question_attempt/templates/respond"] = (function(context) {
    return (function() {
      var $c, $e, $o;
      $e = window.HAML.escape;
      $c = window.HAML.cleanValue;
      $o = [];
      $o.push("<div class='PromptedAudioQuestion lesson_element'>\n  <div class='title'>\n    <h4>" + ($e($c(this.question.title))) + "</h4>\n  </div>\n  <div id='element-content'>" + this.question.content + "</div>\n  <div id='waveform'></div>\n  <div id='wave-timeline'></div>\n  <div id='recordingControls'>\n    <button class='js-record-begin'>record</button>\n    <button class='js-record-end'>stop</button>\n  </div>\n  <div id='recordings'>\n    <ul id='recordings-list'></ul>\n  </div>\n  <div id='recording'>\n    <div class='response_wave'></div>\n    <div class='controls'>\n      <button class='btn' data-action='back'>\n        <i class='icon icon-step-backward'></i>\n        Seek Backward\n      </button>\n      <button class='btn' data-action='play'>\n        <i class='icon icon-play'></i>\n        Play /\n        <i class='icon icon-pause'></i>\n        Pause\n      </button>\n      <button class='btn' data-action='forth'>\n        <i class='icon icon-step-forward'></i>\n        Seek Forward\n      </button>\n      <button class='btn btn-success' data-action='green-mark'>\n        <i class='icon icon-flag'></i>\n        Set green mark\n      </button>\n      <button class='btn btn-danger' data-action='red-mark'>\n        <i class='icon icon-flag'></i>\n        Set red mark\n      </button>\n    </div>\n  </div>\n</div>");
      return $o.join("\n").replace(/\s([\w-]+)='true'/mg, ' $1').replace(/\s([\w-]+)='false'/mg, '').replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(window.HAML.context(context));
  });;
}).call(this);
