"use strict";

(function(window){

  var WORKER_PATH = '/assets/Recorderjs/recorderWorker.js';

  var Recorder = function(source, cfg){
    var config = cfg || {};
    var bufferLen = config.bufferLen || 4096;
    this.context = source.context;
    this.node = (this.context.createScriptProcessor ||
                 this.context.createJavaScriptNode).call(this.context,
                                                         bufferLen, 2, 2);
    var worker = new Worker(config.workerPath || WORKER_PATH);
    worker.postMessage({
      command: 'init',
      config: {
        sampleRate: this.context.sampleRate
      }
    });
    var recording = false,
      currCallback;

    this.node.onaudioprocess = function(e){
      if (!recording) return;
      worker.postMessage({
        command: 'record',
        buffer: [
          e.inputBuffer.getChannelData(0),
          e.inputBuffer.getChannelData(1)
        ]
      });
    }

    this.configure = function(cfg){
      for (var prop in cfg){
        if (cfg.hasOwnProperty(prop)){
          config[prop] = cfg[prop];
        }
      }
    }

    this.record = function(){
      recording = true;
    }

    this.stop = function(){
      recording = false;
    }

    this.clear = function(){
      worker.postMessage({ command: 'clear' });
    }

    this.getBuffer = function(cb) {
      currCallback = cb || config.callback;
      worker.postMessage({ command: 'getBuffer' })
    }

    this.exportWAV = function(cb, type){
      currCallback = cb || config.callback;
      type = type || config.type || 'audio/wav';
      if (!currCallback) throw new Error('Callback not set');
      worker.postMessage({
        command: 'exportWAV',
        type: type
      });
    }

    worker.onmessage = function(e){
      var blob = e.data;
      currCallback(blob);
    }

    source.connect(this.node);
    this.node.connect(this.context.destination);    //this should not be necessary
  };

  Recorder.forceDownload = function(blob, filename){
    var url = (window.URL || window.webkitURL).createObjectURL(blob);
    var link = window.document.createElement('a');
    link.href = url;
    link.download = filename || 'output.wav';
    var click = document.createEvent("Event");
    click.initEvent("click", true, true);
    link.dispatchEvent(click);
  }

  window.Recorder = Recorder;

})(window);
"use strict";

var recLength = 0,
  recBuffersL = [],
  recBuffersR = [],
  sampleRate;

self.onmessage = function(e){
  switch(e.data.command){
    case 'init':
      init(e.data.config);
      break;
    case 'record':
      record(e.data.buffer);
      break;
    case 'exportWAV':
      exportWAV(e.data.type);
      break;
    case 'getBuffer':
      getBuffer();
      break;
    case 'clear':
      clear();
      break;
  }
};

function init(config){
  sampleRate = config.sampleRate;
}

function record(inputBuffer){
  recBuffersL.push(inputBuffer[0]);
  recBuffersR.push(inputBuffer[1]);
  recLength += inputBuffer[0].length;
}

function exportWAV(type){
  var bufferL = mergeBuffers(recBuffersL, recLength);
  var bufferR = mergeBuffers(recBuffersR, recLength);
  var interleaved = interleave(bufferL, bufferR);
  var dataview = encodeWAV(interleaved);
  var audioBlob = new Blob([dataview], { type: type });

  self.postMessage(audioBlob);
}

function getBuffer() {
  var buffers = [];
  buffers.push( mergeBuffers(recBuffersL, recLength) );
  buffers.push( mergeBuffers(recBuffersR, recLength) );
  self.postMessage(buffers);
}

function clear(){
  recLength = 0;
  recBuffersL = [];
  recBuffersR = [];
  console.log("Record length: " + recLength);
}

function mergeBuffers(recBuffers, recLength){
  var result = new Float32Array(recLength);
  var offset = 0;
  for (var i = 0; i < recBuffers.length; i++){
    result.set(recBuffers[i], offset);
    offset += recBuffers[i].length;
  }
  return result;
}

function interleave(inputL, inputR){
  var length = inputL.length + inputR.length;
  var result = new Float32Array(length);

  var index = 0,
    inputIndex = 0;

  while (index < length){
    result[index++] = inputL[inputIndex];
    result[index++] = inputR[inputIndex];
    inputIndex++;
  }
  return result;
}

function floatTo16BitPCM(output, offset, input){
  for (var i = 0; i < input.length; i++, offset+=2){
    var s = Math.max(-1, Math.min(1, input[i]));
    output.setInt16(offset, s < 0 ? s * 0x8000 : s * 0x7FFF, true);
  }
}

function writeString(view, offset, string){
  for (var i = 0; i < string.length; i++){
    view.setUint8(offset + i, string.charCodeAt(i));
  }
}

function encodeWAV(samples){
  var buffer = new ArrayBuffer(44 + samples.length * 2);
  var view = new DataView(buffer);

  /* RIFF identifier */
  writeString(view, 0, 'RIFF');
  /* file length */
  view.setUint32(4, 32 + samples.length * 2, true);
  /* RIFF type */
  writeString(view, 8, 'WAVE');
  /* format chunk identifier */
  writeString(view, 12, 'fmt ');
  /* format chunk length */
  view.setUint32(16, 16, true);
  /* sample format (raw) */
  view.setUint16(20, 1, true);
  /* channel count */
  view.setUint16(22, 2, true);
  /* sample rate */
  view.setUint32(24, sampleRate, true);
  /* byte rate (sample rate * block align) */
  view.setUint32(28, sampleRate * 4, true);
  /* block align (channel count * bytes per sample) */
  view.setUint16(32, 4, true);
  /* bits per sample */
  view.setUint16(34, 16, true);
  /* data chunk identifier */
  writeString(view, 36, 'data');
  /* data chunk length */
  view.setUint32(40, samples.length * 2, true);

  floatTo16BitPCM(view, 44, samples);

  return view;
}
;
(function() {
  $(function() {
    var analyser, audio_context, createDownloadLink, createUploadLink, recorder, startUserMedia, uploadFile, __log;
    __log = function(e, data) {
      console.log("RECORDER: " + e);
      return log.innerHTML += "\n" + e + " " + (data || '');
    };
    audio_context = null;
    recorder = null;
    analyser = null;
    startUserMedia = function(stream) {
      var input, zeroGain;
      input = audio_context.createMediaStreamSource(stream);
      __log('Media stream created.');
      $('#recordingControls').toggle();
      zeroGain = audio_context.createGain();
      zeroGain.gain.value = 0;
      input.connect(zeroGain);
      zeroGain.connect(audio_context.destination);
      __log('Input connected to muted gain node connected to audio context destination.');
      recorder = new Recorder(input);
      return __log('Recorder initialised.');
    };
    window.startRecording = function(button) {
      analyser = audio_context.createAnalyser();
      recorder && recorder.record();
      button.disabled = true;
      button.nextElementSibling.disabled = false;
      return __log('Recording...');
    };
    window.stopRecording = function(button) {
      recorder && recorder.stop();
      button.disabled = true;
      button.previousElementSibling.disabled = false;
      __log('Stopped recording.');
      createDownloadLink();
      return recorder.clear();
    };
    createDownloadLink = function() {
      return recorder && recorder.exportWAV((function(_this) {
        return function(blob) {
          var au, form, hf, li, oReq, url;
          url = URL.createObjectURL(blob);
          li = document.createElement('li');
          au = document.createElement('audio');
          hf = document.createElement('a');
          au.controls = true;
          au.src = url;
          hf.href = url;
          hf.download = new Date().toISOString() + '.wav';
          hf.innerHTML = hf.download;
          li.appendChild(au);
          li.appendChild(hf);
          recordingslist.appendChild(li);
          __log('Uploading file.');
          form = new FormData();
          form.append("recording[file]", blob);
          oReq = new XMLHttpRequest();
          oReq.open("POST", "http://languagelesson.local/recordings");
          return oReq.send(form);
        };
      })(this));
    };
    uploadFile = function() {
      var form, oReq;
      form = new FormData();
      form.append("sound_file", oBlob);
      oReq = new XMLHttpRequest();
      oReq.open("POST", "http://languagelesson.local/submitform");
      return oReq.send(form);
    };
    createUploadLink = function() {
      return recorder && recorder.exportWAV((function(_this) {
        return function(blob) {
          var au, hf, li, url;
          url = URL.createObjectURL(blob);
          li = document.createElement('li');
          au = document.createElement('audio');
          hf = document.createElement('a');
          au.controls = true;
          au.src = url;
          hf.href = url;
          hf.download = 'Upload to server';
          hf.innerHTML = hf.download;
          li.appendChild(au);
          li.appendChild(hf);
          return recordingslist.appendChild(li);
        };
      })(this));
    };
    return window.onload = function() {
      var e;
      $('#recordingControls').hide();
      try {
        window.AudioContext = window.AudioContext || window.webkitAudioContext;
        navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia;
        window.URL = window.URL || window.webkitURL;
        audio_context = new AudioContext;
        __log('Audio context set up.');
        __log('navigator.getUserMedia ' + (navigator.getUserMedia ? 'available.' : 'not present!'));
      } catch (_error) {
        e = _error;
        alert('No web audio support in this browser!');
      }
      return navigator.getUserMedia({
        audio: true
      }, startUserMedia, (function(_this) {
        return function(e) {
          return __log('No live audio input: ' + e);
        };
      })(this));
    };
  });

}).call(this);
