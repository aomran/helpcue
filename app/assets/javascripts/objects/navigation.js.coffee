@HelpCue.Navigation =
  init: ->
    if HelpCue.largeScreen()
      localStorage["expandNav"] ?= true
      expandNav = JSON.parse(localStorage["expandNav"])

      $('body').toggleClass('nav-open', expandNav)
    else
      localStorage.removeItem("expandNav")

    @registerEventHandlers()

  mainUpdate: ->
    if HelpCue.largeScreen()
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
    $('.collapse-toggle').on 'click', (e) =>
      e.preventDefault()
      $('body').toggleClass('nav-open')
      @mainUpdate()
      @subClose()

    $('.subnav-toggle').on 'click', (e) =>
      e.preventDefault()
      @subToggle()
