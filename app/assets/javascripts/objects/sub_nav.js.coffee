@HelpCue.SubNav =
  close: ->
    $('.main').removeClass('subnav-open')
    $('.subnav').removeClass('subnav-show')

  toggle: ->
    $('.main').toggleClass('subnav-open')
    $('.subnav').toggleClass('subnav-show')
    # Hide hover label for Account
    $('.subnav-slide').toggleClass('nav-label-hide')