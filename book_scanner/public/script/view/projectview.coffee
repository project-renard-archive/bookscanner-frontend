app = app || {}

class app.ProjectView extends Backbone.View
    el: '#scan-list'

    # TODO event to scan when hit spacebar
    events: {}

    initialize: ->
      console.log 'init view'
      @collection = new app.Project()
      @collection.fetch({ reset: true })
      # TODO fetch collection
