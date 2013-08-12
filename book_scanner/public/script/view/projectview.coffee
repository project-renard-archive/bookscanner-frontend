app = app || {}
define [ "backbone", "cs!app/collection/project" ], (Backbone, Project) ->
  class app.ProjectView extends Backbone.View
      el: '#scan-list'

      # TODO event to scan when hit spacebar
      events: {}

      initialize: () ->
        console.log 'init view'
        @collection.fetch({ reset: true })
        # TODO fetch collection
