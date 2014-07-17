//= require ./recorder.js

window.RecorderControls = {}
RecorderControls.audio_context = null
RecorderControls.recorder = null
RecorderControls.analyser = null
RecorderControls.recording = false
RecorderControls.recordingEnabled = false
RecorderControls.debug = false

RecorderControls.initialize = ->
  unless RecorderControls.audio_context  
    try
      # webkit shim
      window.AudioContext = window.AudioContext || window.webkitAudioContext
      navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia
      window.URL = window.URL || window.webkitURL

      RecorderControls.audio_context = new AudioContext

      if RecorderControls.debug
        console.log 'Audio context set up.' 
        console.log 'navigator.getUserMedia ' + (if navigator.getUserMedia then 'available.' else 'not present!')
    catch e
      console.log 'No web audio support in this browser'

    try  
      navigator.getUserMedia audio: true, RecorderControls.startUserMedia, (e) =>
        console.log('No live audio input: ' + e)
        RecorderControls.recordingEnabled = true
    catch e
      console.log 'No web audio support in this browser' if RecorderControls.debug

    if RecorderControls.debug
      console.log "Recording enabled?"
      console.log RecorderControls.recordingEnabled  

RecorderControls.startUserMedia = (stream) ->
  try 
    Recorder.input = RecorderControls.audio_context.createMediaStreamSource(stream)
    console.log('Media stream created.') if RecorderControls.debug
  catch e 
    alert(e)
      
  zeroGain = RecorderControls.audio_context.createGain()
  zeroGain.gain.value = 0

  Recorder.input.connect(zeroGain);
  zeroGain.connect(RecorderControls.audio_context.destination);
  console.log('Input connected to muted gain node connected to audio context destination.') if RecorderControls.debug

  RecorderControls.recorder = new Recorder(Recorder.input)
  console.log('Recorder initialised.') if RecorderControls.debug

  RecorderControls.recordingEnabled = true
      
RecorderControls.startRecording = ->
  RecorderControls.recording = true
  
  RecorderControls.analyser = RecorderControls.audio_context.createAnalyser()
  RecorderControls.recorder && RecorderControls.recorder.record()
  console.log('Recording...') if RecorderControls.debug

RecorderControls.stopRecording = ->
  RecorderControls.recording = false
  
  RecorderControls.recorder && RecorderControls.recorder.stop()
  console.log('Stopped recording.') if RecorderControls.debug
  
RecorderControls.toggleRecording = ->
  unless RecorderControls.recording
    RecorderControls.startRecording()
  else
    RecorderControls.stopRecording()
  
RecorderControls.exportWAV = (callback) ->
  RecorderControls.recorder && RecorderControls.recorder.exportWAV((blob) ->
    callback(blob)
  )

RecorderControls.clear = ->
   RecorderControls.recorder && RecorderControls.recorder.clear()
