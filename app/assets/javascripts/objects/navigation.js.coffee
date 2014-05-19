@HelpCue.Navigation =
  init: ->
    if HelpCue.supports_html5_storage()
      if HelpCue.largeScreen()
        # Defaults
        localStorage["expandNav"] ?= true
        # Build UI
        $('body').toggleClass('nav-open', JSON.parse(localStorage["expandNav"]))
      else
        localStorage.removeItem("expandNav")
    @registerEventHandlers()

  mainUpdate: ->
    if HelpCue.supports_html5_storage() && HelpCue.largeScreen()
      if $('body').hasClass('nav-open')
        localStorage["expandNav"] = true
      else
        localStorage["expandNav"] = false

  subClose: ->
    $('.main').removeClass('subnav-open')
    $('.subnav').removeClass('subnav-show')

  subToggle: ->
    $('.main').toggleClass('subnav-open')
    $('.subnav').toggleClass('subnav-show')
    # Hide hover label for Account
    $('.subnav-slide').toggleClass('nav-label-hide')

  registerEventHandlers: ->
    $('.collapse-toggle').on 'click', (e) ->
      e.preventDefault()
      $('body').toggleClass('nav-open')
      HelpCue.Navigation.mainUpdate()
      HelpCue.Navigation.subClose()

    $('.subnav-toggle').on 'click', (e) ->
      e.preventDefault()
      HelpCue.Navigation.subToggle()