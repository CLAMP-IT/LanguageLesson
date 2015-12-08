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
  recordingAcceptor: null
  latestRecording: null

  initialize: ->
    if (! Recorder.isRecordingSupported())
      return screenLogger("Recording features are not supported in your browser.")

    @recorder = new Recorder
      monitorGain: 0
      numberOfChannels: 1
      bitRate: 64000
      encoderSampleRate: 48000

    @recordingEnabled = true

    @recorder.initStream()

    @recorder.addEventListener 'dataAvailable', @handleRecording
    console.log 'listener added'
    #@analyser = @audio_context.createAnalyser()

  startUserMedia: (stream) =>
    try
      Recorder.input = @audio_context.createMediaStreamSource(stream)
      console.log('Media stream created.') if @debug
    catch error
      console.log error

    zeroGain = @audio_context.createGain()
    zeroGain.gain.value = 0

    Recorder.input.connect(zeroGain)
    zeroGain.connect(@audio_context.destination)
    console.log('Input connected to muted gain node connected to audio context destination.') if @debug

    @recorder = new Recorder(Recorder.input)
    console.log('Recorder initialised.') if @debug

    @recordingEnabled = true

  startRecording: ->
    @recording = true

    @recorder && @recorder.start()
    console.log('Recorder enabled') if @debug

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
      console.log 'start'

      @startRecording()
    else
      console.log 'stop'

      @stopRecording()

  clear: ->
    #@recorder && @recorder.clear()

  onRecordingInterval: (interval, callback) ->
    @recordingInterval = interval
    @recordingIntervalCallback = callback

  handleRecording: (e) =>
    console.log 'accept it?'
    @latestRecording = e.detail

    if @recordingAcceptor
      @recordingAcceptor.acceptRecording @latestRecording
    else
      console.log 'No object to accept recording'

  getLatestRecording: =>
    @latestRecording

  setRecordingAcceptor: (object) =>
    @recordingAcceptor = object

    return
