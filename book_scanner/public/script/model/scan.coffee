app = app || {}
define [ "backbone" ], (Backbone) ->
  Backbone = require("backbone")
  class app.Scan extends Backbone.Model
      defaults:
        image: 'test'
