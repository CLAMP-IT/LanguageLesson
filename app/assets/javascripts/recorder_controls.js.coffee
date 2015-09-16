//= require ../../../vendor/assets/javascripts/Recorderjs/recorder.js

@RecorderControls =
  audio_context: null
  recorder: null
  analyser: null
  recording: false
  recordingEnabled: false
  debug: false
  recordingInterval: null
  recordingIntervalCallback: null
  intervalFunction: null

  initialize: ->
    _.bindAll(@, 'startUserMedia')

    if (! Recorder.isRecordingSupported())
      return screenLogger("Recording features are not supported in your browser.")

    @recorder = new Recorder
      monitorGain: 0
      numberOfChannels: 1
      bitRate: 64000
      encoderSampleRate: 48000

    @recordingEnabled = true

    @recorder.initStream()

    console.log @recorder

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

    #@analyser = @audio_context.createAnalyser()
    @recorder && @recorder.start()
    console.log('Recording...') if @debug

    if @recordingInterval && @recordingIntervalCallback
      @intervalFunction = setInterval(@recordingIntervalCallback, @recordingInterval)

  stopRecording: ->
    @recording = false

    @recorder && @recorder.stop()
    console.log('Stopped recording.') if @debug

    if @intervalFunction
      clearInterval(@intervalFunction)

  toggleRecording: ->
    unless @recording
      @startRecording()
    else
      @stopRecording()

  clear: ->
    #@recorder && @recorder.clear()

  onRecordingInterval: (interval, callback) ->
    @recordingInterval = interval
    @recordingIntervalCallback = callback
