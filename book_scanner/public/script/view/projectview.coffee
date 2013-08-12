app = app || {}
define [ "module", "backbone",
  "cs!app/collection/project"
  "cs!app/view/scanview", "elastislide" ],
(module, Backbone, Project, ScanView) ->
  KEY_SPACE = 32
  class app.ProjectView extends Backbone.View
    el: '#scan-list'
    add_scan_url: module.config().scan_url # action URL
    event_el: 'body'

    events: {
      'keypress': '_handle_key'
    }

    initialize: () ->
      @collection.fetch({ reset: true })
      @render
      $(@event_el).on('keypress', @_handle_key)

      # create a vertical carousel
      $(@el).elastislide
        orientation : 'vertical'
        minItems: 1
      @carousel = $(@el).data().elastislide # to get around the broken code in elastislide
      #$(@el).html('')

      @listenTo @collection, 'add', @_render_scan
      @listenTo @collection, 'reset', @render

    render: ->
      @collection.each (item) =>
        @_render_scan item

    _render_scan: (item) ->
      scan_view = new ScanView
        model: item
      $(@el).append scan_view.render().el
      @carousel.add() # update carousel

    _handle_key: (e) =>
      key = event.keyCode or event.which
      switch key
        when KEY_SPACE then @_add_scan(e)
        # Let any other key continue its way to keypress.
        else return true
      return false

    # event to scan when hit spacebar
    _add_scan: (e) ->
      e.preventDefault()
      $.getJSON @add_scan_url, (data) =>
        # add to collection
        @collection.create data
