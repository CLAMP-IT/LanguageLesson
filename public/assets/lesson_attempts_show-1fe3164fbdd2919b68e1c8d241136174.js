(function() {
  this.SimpleAudio = {};

  SimpleAudio.togglePlayLocal = function(element) {
    var audio_element, icon;
    audio_element = $(element).closest('.simple-audio-player').find('.audio_element').get(0);
    icon = $(element).closest('.simple-audio-player').find('.playicon');
    if (audio_element.paused) {
      icon.toggleClass('icon-play icon-pause');
      return audio_element.play();
    } else {
      icon.toggleClass('icon-play icon-pause');
      return audio_element.pause();
    }
  };

  SimpleAudio.rewind = function(element) {
    var audio_element;
    audio_element = $(element).closest('.simple-audio-player').find('.audio_element').get(0);
    audio_element.currentTime = 0;
    return audio_element.play();
  };

  SimpleAudio.updateProgress = function() {
    var audio_element, percent, progress, value;
    audio_element = $(this).closest('.simple-audio-player').find('.audio_element').get(0);
    progress = $(this).closest('.simple-audio-player').find('.seekbar').get(0);
    value = 0;
    percent = Math.floor((100 / audio_element.duration) * audio_element.currentTime);
    progress.value = percent;
    return progress.getElementsByTagName('span')[0].innerHTML = percent;
  };

  SimpleAudio.checkForEnd = function() {
    var audio_element, icon, progress;
    audio_element = $(this).closest('.simple-audio-player').find('.audio_element').get(0);
    progress = $(this).closest('.simple-audio-player').find('.seekbar').get(0);
    icon = $(this).closest('.simple-audio-player').find('.playicon');
    audio_element.pause();
    icon.toggleClass('icon-play icon-pause');
    return progress.value = 0;
  };

  SimpleAudio.activate = function() {
    return $(".simple-audio-player").each(function(element) {
      var append, audio_element, src;
      console.log(element);
      src = $(this).data('src');
      append = "<audio class=\"audio_element\" src=\"" + src + "\"></audio>\n<button class=\"btn\" onclick='SimpleAudio.togglePlayLocal(this)'><i class='glyphicon glyphicon-play'></i></button>\n<button class=\"btn\" onclick='SimpleAudio.rewind(this)'><i class='glyphicon glyphicon-step-backward'></i></button>\n<progress class=\"seekbar\" value=\"0\" max=\"100\"><span>0</span>% played</progress>";
      $(this).append(append);
      audio_element = $(this).find('.audio_element').get(0);
      audio_element.addEventListener('timeupdate', SimpleAudio.updateProgress, false);
      return audio_element.addEventListener('ended', SimpleAudio.checkForEnd, false);
    });
  };

}).call(this);
(function() {


}).call(this);
