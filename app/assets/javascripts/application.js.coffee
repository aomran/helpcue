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
#= require jquery-editable-poshytip
#= require jquery.modal
#= require jquery.timeago
#= require jquery.tinysort
#= require utilities
#= require_tree ./objects
#= require_tree .

$ = jQuery

$ ->
  # Navigation
  HelpCue.Navigation.init()

  # SegmentIO
  if HelpCue.user
    userData =
      email: HelpCue.user.email
      created: HelpCue.user.created_at
      firstName: HelpCue.user.first_name
      lastName: HelpCue.user.last_name

    analytics.identify(HelpCue.user.id, userData)

  $('a.open-modal').click ->
    HelpCue.Navigation.subClose()
    $('.error-message').remove()
    $(this).modal(fadeDuration: 250, fadeDelay: 0.5)
    return false

  $('[data-dismiss="alert"]').on 'click', ->
    $(this).closest('.flash').fadeOut ->
      $(this).remove()

$.timeago.settings.strings =
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