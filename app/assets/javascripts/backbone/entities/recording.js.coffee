@LanguageLesson.module "Entities",(Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Recording extends Entities.AssociatedModel
    urlRoot: -> Routes.recordings_path()

    saveRecording: ->
      @set('recordable_type', @parents[0].rubyClass)
      @set('recordable_id', @parents[0].get('id'))
      console.log @

      form = new FormData()
      form.append "[recording][file]", @get('blob'), 'recording.wav'
      form.append "[recording][recordable_type]", @get('recordable_type')
      form.append "[recording][recordable_id]", @get('recordable_id')

      postUrl = '/recordings'
      oReq = new XMLHttpRequest()
      oReq.open("POST", postUrl)
      oReq.send(form)   
      
    getUrl: =>
      if @get('blob')
        return window.URL.createObjectURL( @get('blob') )
      else if @get('full_url')
        return @get('full_url')
      else
        return null

  API =
    createRecording: ->
      new Entities.Recording

  App.reqres.setHandler "create:recording:entity", ->
    API.createRecording()
