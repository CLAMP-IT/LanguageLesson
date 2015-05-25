createCORSRequest: (method, url) ->
  xhr = new XMLHttpRequest()

  if xhr.withCredentials?
    xhr.open method, url, true
  else if typeof XDomainRequest != "undefined"
    xhr = new XDomainRequest()
    xhr.open method, url
  else
    xhr = null
  xhr
