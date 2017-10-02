window.SampleApp ||= {}

SampleApp.init = ->
  @navDrawer = new SampleApp.NavDrawer('#nav_drawer', 'nav .fa-navicon', -> true)
  new SampleApp.Dismissable('.flash-message button')

$(document).ready ->
  SampleApp.init()

$(document).on 'turbolinks:load', ->
  new SampleApp.Dismissable('.flash-message button')

  if SampleApp.navDrawer.isStale()
    SampleApp.navDrawer = new SampleApp.NavDrawer('#nav_drawer', 'nav .fa-navicon', -> true)
