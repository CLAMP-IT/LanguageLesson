//= require simple_audio_player

@RecordingApp = {}

RecordingApp.uploadFile = (blob) ->
  form = document.getElementById('new_question_attempt')
  #$('#new_question_attempt')

  formdata = new FormData(form);  
    #form.append("username", "Groucho");
    #form.append("accountnum", 123456); // number 123456 is immediately converted to string "123456"

    # HTML file input user's choice...
    #form.append("userfile", fileInputElement.files[0]);

    # JavaScript file-like object...
    # var oFileBody = '<a id="a"><b id="b">hey!</b></a>'; // the body of the new file...
    # var oBlob = new Blob([oFileBody], { type: "text/xml"});

  formdata.append("recording[file]", blob)

  oReq = new XMLHttpRequest()
  oReq.open("POST", form.action)
  oReq.send(formdata)
