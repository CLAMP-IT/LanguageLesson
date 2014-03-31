//= require_tree ./Recorderjs

$ ->
  __log = (e, data) ->
    console.log("RECORDER: #{e}")
    log.innerHTML += "\n" + e + " " + (data || '')

  audio_context = null
  recorder = null
  analyser = null

  startUserMedia = (stream) ->
    try 
      input = audio_context.createMediaStreamSource(stream)
      __log('Media stream created.')
    catch e 
      alert(e)
      
    $('#recordingControls').toggle()

    zeroGain = audio_context.createGain()
    zeroGain.gain.value = 0

    input.connect(zeroGain);
    zeroGain.connect(audio_context.destination);
    __log('Input connected to muted gain node connected to audio context destination.');

    #input.connect(audio_context.destination)
    #__log('Input connected to audio context destination.')

    recorder = new Recorder(input)
    __log('Recorder initialised.')

  window.startRecording = (button) ->
    analyser = audio_context.createAnalyser()

    recorder && recorder.record()
    button.disabled = true
    button.nextElementSibling.disabled = false
    __log('Recording...')

  window.stopRecording = (button) ->
    recorder && recorder.stop()
    button.disabled = true
    button.previousElementSibling.disabled = false
    __log('Stopped recording.')

    # create WAV download link using audio data blob
    createDownloadLink()

    # create WAV download link using audio data blob
    #createUploadLink()

    recorder.clear()

  createDownloadLink = ->
    recorder && recorder.exportWAV (blob) =>
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
      recordingslist.appendChild(li)

      __log('Uploading file.')
      form = new FormData()

      form.append("recording[file]", blob)

      oReq = new XMLHttpRequest()
      oReq.open("POST", "http://languagelesson.local/recordings")
      oReq.send(form)

  uploadFile = ->
    form = new FormData()

    #form.append("username", "Groucho");
    #form.append("accountnum", 123456); // number 123456 is immediately converted to string "123456"

    # HTML file input user's choice...
    #form.append("userfile", fileInputElement.files[0]);

    # JavaScript file-like object...
    # var oFileBody = '<a id="a"><b id="b">hey!</b></a>'; // the body of the new file...
    # var oBlob = new Blob([oFileBody], { type: "text/xml"});

    form.append("sound_file", oBlob);

    oReq = new XMLHttpRequest()
    oReq.open("POST", "http://languagelesson.local/submitform")
    oReq.send(form)

  createUploadLink = ->
    recorder && recorder.exportWAV (blob) =>
      url = URL.createObjectURL(blob)
      li = document.createElement('li')
      au = document.createElement('audio')
      hf = document.createElement('a')

      au.controls = true
      au.src = url
      hf.href = url
      hf.download = 'Upload to server'
      hf.innerHTML = hf.download
      li.appendChild(au)
      li.appendChild(hf)
      recordingslist.appendChild(li)

  window.onload = ->
    $('#recordingControls').hide()

    try
      # webkit shim
      window.AudioContext = window.AudioContext || window.webkitAudioContext
      navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia
      window.URL = window.URL || window.webkitURL

      audio_context = new AudioContext
      __log 'Audio context set up.'
      __log 'navigator.getUserMedia ' + (if navigator.getUserMedia then 'available.' else 'not present!')
    catch e
      alert('No web audio support in this browser!')
  
    navigator.getUserMedia audio: true, startUserMedia, (e) =>
      __log('No live audio input: ' + e)

