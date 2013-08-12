define ["backbone"
  "cs!app/view/projectview",
  "cs!app/collection/project",
  "module",
  ],
  (Backbone, ProjectView, Project, module) ->
    class app
      constructor: ->
        # use {{ template delimiters }}
        _.templateSettings.interpolate = /\{\{(.+?)\}\}/g
        _.templateSettings.escape = /\{\{-(.*?)\}\}/g

        collection = new Project
          url: module.config().url
        new ProjectView
          collection: collection
