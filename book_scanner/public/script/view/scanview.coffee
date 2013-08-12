app = app || {}

define [ "backbone" ], (Backbone) ->
  class app.ScanView extends Backbone.View
    tagName: 'li'
    className: 'scan'
    template: _.template( $( '#scan-template' ).html(), undefined, { variable: 'data' } ),

    render: ->
      $(@el).html @template(@model.toJSON())
      @
