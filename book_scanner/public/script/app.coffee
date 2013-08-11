app = app || {}

# use {{ template delimiters }}
_.templateSettings.interpolate = /\{\{(.+?)\}\}/g
_.templateSettings.escape = /\{\{-(.*?)\}\}/g

#window.start_app = ( url ) ->
  #collection = new app.Project
    #url: url
  #new app.ProjectView
    #collection: collection

#$ ->
  #new app.ProjectView()

