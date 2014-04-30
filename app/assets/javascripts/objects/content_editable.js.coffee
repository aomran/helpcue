@HelpCue.ContentEditable =
  enable: (el) ->
    el.attr('contenteditable', true)
    el.trigger('focus')

  store_original: (el) ->
    localStorage.setItem('originalText', el.html())

  restore_original: (el) ->
    el.html(localStorage.getItem('originalText'))
    el.trigger('blur')
    el.attr('contenteditable', false)

  update_content: (el, content) ->
    el.html(content)
    el.trigger('blur')
    el.attr('contenteditable', false)