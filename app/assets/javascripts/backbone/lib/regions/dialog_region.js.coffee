@LanguageLesson.module "Regions", (Regions, App, Backbone, Marionette, $, _) ->
  class Regions.Dialog extends Marionette.Region
    onShow: (view) ->
      #console.log @$el
      $('#dualog').modal()
      $('#dualog').modal('show')
      #@setupBindings view

      #options = @getDefaultOptions _.result(view, "dialog")

      #@openDialog options

    setupBindings: (view) ->
      @listenTo view, "dialog:close", @close

    getDefaultOptions: (options = {}) ->
      _.defaults options,
        title: "default title"
        dialogClass: options.className ? ""
        size: "small"

    openDialog: (options) ->
      # @$el.on "open", -> console.log "open"
      # @$el.on "opened", -> console.log "opened"
      # @$el.on "close", -> console.log "close"
      # @$el.on "closed", -> console.log "closed"

      # @$el
      #   .addClass("reveal-modal")
      #     .addClass(options.size)
      #       .addClass(options.dialogClass)
      #         .foundation("reveal", "open")
      #           .prepend("<h3>" + @getTitle(options) + "</h3>")

      ## when foundation fires the closed event we want to close this region
      ## which will properly close our view and unbind all events
      @$el.on "closed", => @close()

    getTitle: (options) ->
      _.result options, "title"

    onDestroy: ->
      ## make sure to remove any listeners on the $el here
      @$el.off "closed"

      @stopListening()
      @$el.foundation("reveal", "close")
