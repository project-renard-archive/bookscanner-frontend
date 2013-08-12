app = app || {}
define [ "backbone", "cs!app/collection/project" ], (Backbone, Project) ->
  class app.ProjectView extends Backbone.View
      el: '#scan-list'

      # TODO event to scan when hit spacebar
      events: {}

      initialize: (attr, options) ->
        console.log 'init view'
        @collection = attr.collection if attr and 'collection' of attr
        @collection.fetch({ reset: true })
        # TODO fetch collection
