//= require ./simple_audio_player

$ ->
  wavesurfer = Object.create(WaveSurfer)

  wavesurfer.init
    container     : '#waveform',
    fillParent    : true,
    markerColor   : 'rgba(0, 0, 0, 0.5)',
    frameMargin   : 0.1,
    maxSecPerPx   : parseFloat(location.hash.substring(1)),
    loadPercent   : true,
    waveColor     : 'orange',
    progressColor : 'red',
    loadingColor  : 'purple',
    xcursorColor   : 'navy'

  wavesurfer.load( $('#audio-player').data().fileurl )

  eventHandlers =
    'play': ->
      wavesurfer.playPause()

    'green-mark': ->
      wavesurfer.mark
        id: "up"
        color: "rgba(0, 255, 0, 0.5)"

    "red-mark": ->
      wavesurfer.mark
        id: "down"
        color: "rgba(255, 0, 0, 0.5)"

    back: ->
      wavesurfer.skipBackward()

    forth: ->
      wavesurfer.skipForward()

  document.addEventListener "keyup", (e) ->
    map =
      32: "play"       # Space
      38: "green-mark" # Up arrow
      40: "red-mark"   # Down arrow
      37: "back"       # Left arrow
      39: "forth"      # Right arrow

    if e.keyCode of map
      handler = eventHandlers[map[e.keyCode]]
      e.preventDefault()
      handler and handler(e)

  document.addEventListener "click", (e) ->
    action = e.target.dataset and e.target.dataset.action
    eventHandlers[action] e  if action and action of eventHandlers
