# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require jquery.ui.effect-highlight
#= require matchMedia
#= require bootstrap-dismiss
#= require jquery.modal
#= require jquery.timeago
#= require utilities
#= require_tree ./objects
#= require_tree .

$ = jQuery

$ ->
  # Navigation
  if $('.fixed-nav').length
    HelpCue.MainNav.init()

    $('.collapse-toggle').on 'click', (e) ->
      e.preventDefault()
      $('body').toggleClass('nav-open')
      HelpCue.MainNav.update()
      HelpCue.SubNav.close()

    $('.subnav-toggle').on 'click', (e) ->
      e.preventDefault()
      HelpCue.SubNav.toggle()

  # SegmentIO
  if HelpCue.user
    userData =
      email: HelpCue.user.email
      classRole: HelpCue.user.classrole_type
      created: HelpCue.user.created_at
      firstName: HelpCue.user.first_name || 'No'
      lastName: HelpCue.user.last_name || 'Name'

    analytics.identify(HelpCue.user.id, userData)

  $('a.open-modal').click ->
    HelpCue.SubNav.close()
    $('.error-message').remove()
    $(this).modal(fadeDuration: 250)
    return false

jQuery.timeago.settings.strings =
  prefixAgo: null
  prefixFromNow: null
  suffixAgo: ""
  suffixFromNow: ""
  seconds: "now"
  minute: "1 m"
  minutes: "%d m"
  hour: "1 h"
  hours: "%d h"
  day: "1 d"
  days: "%d d"
  month: "1 mo"
  months: "%d mo"
  year: "1 yr"
  years: "%d yr"
  wordSeparator: " "
  numbers: []