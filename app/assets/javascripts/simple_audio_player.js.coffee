@SimpleAudio = {}

SimpleAudio.togglePlayLocal = (element) ->
  audio_element = $(element).closest('.simple-audio-player').find('.audio_element').get(0)
  icon =  $(element).closest('.simple-audio-player').find('.playicon')

  if audio_element.paused
    icon.toggleClass('icon-play icon-pause')
    audio_element.play()
  else
    icon.toggleClass('icon-play icon-pause')
    audio_element.pause()

SimpleAudio.rewind = (element) ->
  audio_element = $(element).closest('.simple-audio-player').find('.audio_element').get(0)
  audio_element.currentTime = 0  
  audio_element.play()

SimpleAudio.updateProgress = () ->
  audio_element = $(this).closest('.simple-audio-player').find('.audio_element').get(0)
  progress = $(this).closest('.simple-audio-player').find('.seekbar').get(0)
  value = 0

  percent = Math.floor((100 / audio_element.duration) * audio_element.currentTime)
  progress.value = percent
  progress.getElementsByTagName('span')[0].innerHTML = percent

SimpleAudio.checkForEnd = () ->
  audio_element = $(this).closest('.simple-audio-player').find('.audio_element').get(0)
  progress = $(this).closest('.simple-audio-player').find('.seekbar').get(0)
  icon = $(this).closest('.simple-audio-player').find('.playicon')

  audio_element.pause()
  icon.toggleClass('icon-play icon-pause')
  progress.value = 0

SimpleAudio.activate = () ->
  # Simple audio player
  $(".simple-audio-player").each (element) ->
    console.log element
    src = $(this).data('src')

    append = """
      <audio class="audio_element" src="#{src}"></audio>
      <button class="btn" onclick='SimpleAudio.togglePlayLocal(this)'><i class='glyphicon glyphicon-play'></i></button>
      <button class="btn" onclick='SimpleAudio.rewind(this)'><i class='glyphicon glyphicon-step-backward'></i></button>
      <progress class="seekbar" value="0" max="100"><span>0</span>% played</progress>
    """
    
    $(this).append(append)
    audio_element = $(this).find('.audio_element').get(0)
    audio_element.addEventListener('timeupdate', SimpleAudio.updateProgress, false)
    audio_element.addEventListener('ended', SimpleAudio.checkForEnd, false)
  
#$ ->
#  SimpleAudio.activate()
    
