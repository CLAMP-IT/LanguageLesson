@LanguageLesson.module "Entities",(Entities, App, Backbone, Marionette, $, _) ->
  class Entities.Recording extends Entities.AssociatedModel
    urlRoot: -> Routes.recordings_path()

    getUrl: =>
      if @get('blob')
        return window.URL.createObjectURL( @get('blob') )
      else if @get('full_url')
        return @get('full_url')
      else
        return null

    uploadRecording: (afterUploadCallback) =>
      unless @get('blob')
        console.log 'No blob to save!'
      else
        $.getJSON Routes.backbone_signS3put_path(format: 'json'), (data) =>
          form = new FormData()
          for index, value of data.signed_post
            form.append(index, value)

          form.append("file", @get('blob'), @get('file_name'))

          $.ajax
            url: data.url
            type: "POST"
            data: form
            processData: false
            contentType: false
            success: (response) =>
              s3_key = $(response).find("Key").text()

              @set('uuid', data.uuid)
              @set('url', s3_key)
              @set('bucket_name',data.bucket)
              @set('file_size', @get('blob').size)
              @set('content_type', @get('blob').type)

              # Remove the blob, it's no longer needed.
              @unset('blob')

      afterUploadCallback()

  API =
    createRecording: (file_name) ->
      new Entities.Recording
        file_name: file_name || 'recording.ogg'

  App.reqres.setHandler "create:recording:entity", ->
    API.createRecording()
