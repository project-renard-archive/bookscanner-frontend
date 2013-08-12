app = app || {}
define [ "backbone", "cs!app/model/scan" ], (Backbone, Scan) ->
  class app.Project extends Backbone.Collection
      model: Scan
      url: ''

      initialize: (attr, options) ->
        @url = attr.url if attr and "url" of attr
