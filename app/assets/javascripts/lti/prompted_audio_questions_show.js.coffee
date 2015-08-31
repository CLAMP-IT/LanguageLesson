//= require simple_audio_player

@RecordingApp = {}

RecordingApp.uploadFile = (blob) ->
    #form = new FormData()
    form = $('#new_question_attempt')
    alert(form.attr('target'))
    #form.append("username", "Groucho");
    #form.append("accountnum", 123456); // number 123456 is immediately converted to string "123456"

    # HTML file input user's choice...
    #form.append("userfile", fileInputElement.files[0]);

    # JavaScript file-like object...
    # var oFileBody = '<a id="a"><b id="b">hey!</b></a>'; // the body of the new file...
    # var oBlob = new Blob([oFileBody], { type: "text/xml"});

    #form.append("sound_file", oBlob);

    #oReq = new XMLHttpRequest()
    #oReq.open("POST", "http://languagelesson.local/submitform")
    #oReq.send(form)
