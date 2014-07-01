'use strict';

// Create an instance
var wavesurfer = Object.create(WaveSurfer);

// Init & load audio file
document.addEventListener('DOMContentLoaded', function () {
    // Init
    wavesurfer.init({
        container: document.querySelector('#waveform'),
        waveColor: '#A8DBA8',
        progressColor: '#3B8686',
        minPxPerSec: 50,
        scrollParent: true
    });

    // Load media
    wavesurfer.loadStream('../panner/media.wav');

    // Log errors
    wavesurfer.on('error', function (msg) {
        console.log(msg);
    });

    // Bind play/pause button
    document.querySelector('#play').addEventListener('click', function () {
        wavesurfer.playPause();
    });

    // Progress bar
    (function () {
        var progressDiv = document.querySelector('#progress-bar');
        var progressBar = progressDiv.querySelector('.progress-bar');

        var showProgress = function (percent) {
            progressDiv.style.display = 'block';
            progressBar.style.width = percent + '%';
        };

        var hideProgress = function () {
            progressDiv.style.display = 'none';
        };

        wavesurfer.on('loading', showProgress);
        wavesurfer.on('ready', hideProgress);
        wavesurfer.on('destroy', hideProgress);
        wavesurfer.on('error', hideProgress);
    }());
});
