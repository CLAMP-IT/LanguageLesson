//= require Recorderjs/recorder.js

window.RecorderControls = {}
RecorderControls.audio_context = null
RecorderControls.recorder = null
RecorderControls.analyser = null
RecorderControls.recording = false

RecorderControls.initialize = ->
  unless RecorderControls.audio_context  
    try
      # webkit shim
      window.AudioContext = window.AudioContext || window.webkitAudioContext
      navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia
      window.URL = window.URL || window.webkitURL

      RecorderControls.audio_context = new AudioContext
      console.log 'Audio context set up.'
      console.log 'navigator.getUserMedia ' + (if navigator.getUserMedia then 'available.' else 'not present!')
    catch e
      alert('No web audio support in this browser!')

    navigator.getUserMedia audio: true, RecorderControls.startUserMedia, (e) =>
      console.log('No live audio input: ' + e)
  
RecorderControls.startUserMedia = (stream) ->
  try 
    Recorder.input = RecorderControls.audio_context.createMediaStreamSource(stream)
    console.log('Media stream created.')
  catch e 
    alert(e)
      
  zeroGain = RecorderControls.audio_context.createGain()
  zeroGain.gain.value = 0

  Recorder.input.connect(zeroGain);
  zeroGain.connect(RecorderControls.audio_context.destination);
  console.log('Input connected to muted gain node connected to audio context destination.');

  RecorderControls.recorder = new Recorder(Recorder.input)
  console.log('Recorder initialised.')
  #RecorderControls.recorder.record()
  
RecorderControls.startRecording = ->
  RecorderControls.recording = true
  
  RecorderControls.analyser = RecorderControls.audio_context.createAnalyser()
  RecorderControls.recorder && RecorderControls.recorder.record()
  console.log('Recording...')

RecorderControls.stopRecording = ->
  RecorderControls.recording = false
  
  RecorderControls.recorder && RecorderControls.recorder.stop()
  console.log('Stopped recording.')
  
  #RecorderControls.upload()

  #RecorderControls.recorder.clear()

RecorderControls.toggleRecording = ->
  unless RecorderControls.recording
    RecorderControls.startRecording()
  else
    RecorderControls.stopRecording()
  
RecorderControls.upload = ->
  RecorderControls.recorder && RecorderControls.recorder.exportWAV((blob) ->
    url = URL.createObjectURL(blob)
    li = document.createElement('li')
    au = document.createElement('audio')
    hf = document.createElement('a')

    au.controls = true
    au.src = url
    hf.href = url
    hf.download = new Date().toISOString() + '.wav'
    hf.innerHTML = hf.download
    li.appendChild(au)
    li.appendChild(hf)
    #recordingslist.appendChild(li)
  
    console.log('Uploading file.')
    form = new FormData()
  
    form.append("recording[file]", blob)

    oReq = new XMLHttpRequest()
    oReq.open("POST", "http://languagelesson.local/recordings.json")
    oReq.send(form)    
    return
  )
  return

RecorderControls.exportWAV = (callback) ->
  RecorderControls.recorder && RecorderControls.recorder.exportWAV((blob) ->
    callback(blob)
  )

RecorderControls.clear = ->
   RecorderControls.recorder && RecorderControls.recorder.clear()
