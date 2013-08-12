# this needs to be done first before any templates are evaluated
require ["underscore"], (_) ->
  # use {{ template delimiters }}
  _.templateSettings.interpolate = /\{\{(.+?)\}\}/g
  _.templateSettings.escape = /\{\{-(.*?)\}\}/g

define ["backbone"
  "cs!app/view/projectview",
  "cs!app/collection/project",
  "module",
  ],
  (Backbone, ProjectView, Project, module) ->
    class app
      constructor: ->
        collection = new Project [],
          url: module.config().url
        new ProjectView
          collection: collection
