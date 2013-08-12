app = app || {}
define [ "backbone", "cs!app/model/scan" ], (Backbone, Scan) ->
  class app.Project extends Backbone.Collection
      model: Scan
      #url: '' # must be passed in
