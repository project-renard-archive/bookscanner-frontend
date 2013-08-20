app = app || {}
define [ "backbone" ], (Backbone) ->
  class app.Scan extends Backbone.Model
      defaults:
        'scan-image': 'test'
