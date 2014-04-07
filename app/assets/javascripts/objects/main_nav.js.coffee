@HelpCue.MainNav =
  init: ->
    if HelpCue.supports_html5_storage()
      if HelpCue.largeScreen()
        # Defaults
        localStorage["expandNav"] ?= true
        # Build UI
        $('body').toggleClass('nav-open', JSON.parse(localStorage["expandNav"]))
      else
        localStorage.removeItem("expandNav")

  update: ->
    if HelpCue.supports_html5_storage() && HelpCue.largeScreen()
      if $('body').hasClass('nav-open')
        localStorage["expandNav"] = true
      else
        localStorage["expandNav"] = false