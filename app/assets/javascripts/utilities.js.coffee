@HelpCue ?= {}

@HelpCue.supports_html5_storage = ->
  try
    return "localStorage" of window and window["localStorage"] isnt null
  catch e
    return false

@HelpCue.largeScreen = ->
  return window.matchMedia("(min-width: 1024px)").matches

@HelpCue.mobileScreen = ->
  return window.matchMedia("(max-width: 480px)").matches

@HelpCue.form_validations = (resource, errors) ->
  $('.error-message').remove()
  for field, error of errors
    $input = $("##{resource}_#{field}")
    $error = $('<span>').addClass('error-message h6').text(error)
    $input.addClass('error').before($error)

@HelpCue.clear_modal = ->
  $modal = $('.modal')
  $modal.find('input[type="text"]').each ->
    $(this).val('')
  $modal.find('textarea').each ->
    $(this).val('')
  $.modal.close()