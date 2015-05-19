//= require ./recorder.js

@RecorderControls =
  audio_context: null
  recorder: null
  analyser: null
  recording: false
  recordingEnabled: false
  debug: false

  initialize: ->
    _.bindAll(@, 'startUserMedia')

    unless @audio_context
      try
        # webkit shim
        window.AudioContext = window.AudioContext || window.webkitAudioContext
        navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia
        window.URL = window.URL || window.webkitURL

        @audio_context = new AudioContext

        if @debug
          console.log 'Audio context set up.'
          console.log 'navigator.getUserMedia ' + (if navigator.getUserMedia then 'available.' else 'not present!')
      catch e
        console.log 'No web audio support in this browser'

      try
        navigator.getUserMedia audio: true, @startUserMedia, (e) =>
          console.log('No live audio input: ' + e)
          @recordingEnabled = true
      catch e
        console.log 'No web audio support in this browser' if @debug

      if @debug
        console.log "Recording enabled?"
        console.log @recordingEnabled

  startUserMedia: (stream) ->
    #console.log @
    try
      Recorder.input = @audio_context.createMediaStreamSource(stream)
      console.log('Media stream created.') if @debug
    catch error
      console.log error

    zeroGain = @audio_context.createGain()
    zeroGain.gain.value = 0

    Recorder.input.connect(zeroGain);
    zeroGain.connect(@audio_context.destination);
    console.log('Input connected to muted gain node connected to audio context destination.') if @debug

    @recorder = new Recorder(Recorder.input)
    console.log('Recorder initialised.') if @debug

    @recordingEnabled = true

  startRecording: ->
    @recording = true

    @analyser = @audio_context.createAnalyser()
    @recorder && @recorder.record()
    console.log('Recording...') if @debug

  stopRecording: ->
    @recording = false

    @recorder && @recorder.stop()
    console.log('Stopped recording.') if @debug

  toggleRecording: ->
    unless @recording
      @startRecording()
    else
      @stopRecording()

  exportWAV: (callback) ->
    @recorder && @recorder.exportWAV((blob) ->
      callback(blob)
    )

  clear: ->
     @recorder && @recorder.clear()
