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
    $modal = $('.modal.current')
    $input = $modal.find("##{resource}_#{field}")
    $error = $('<span>').addClass('error-message h6').text(error)
    $input.addClass('error').before($error)

@HelpCue.clear_modal = ->
  $modal = $('.modal')
  $modal.find('input[type="text"]').each ->
    $(this).val('')
  $modal.find('textarea').each ->
    $(this).val('')
  $.modal.close()

@HelpCue.timeago = ->
  $('.timeago').each ->
    $this = $(this)
    if $this.data('active') != 'yes'
      $this.timeago().data('active','yes')

@HelpCue.linkHashtags = (data) ->
 hashpattern = /(#[A-Za-z0-9-_]+)/g;
 data.question.replace hashpattern, ($0) ->
   with_hash = $0
   "<a href='/classrooms/#{data.classroom_id}/hashtags/#{$0.replace(/#/, '')}'>" + with_hash + "</a>"

@HelpCue.editable = ->
  $('.editable').editable(
    success: (response, newValue) -> HelpCue.RequestsList.realtimeRequests(response)
    onblur: 'ignore'
    emptytext: 'Click to enter text'
  )

@HelpCue.tinysort = (data) ->
  $sort_el = $('#sort-type')
  $sort_el.data('sorttype', data.sortType) if data

  sort_type = $sort_el.data('sorttype')
  $('#sort-type a').removeClass('active')
  $(".sort-by-#{sort_type}").addClass('active')

  if sort_type == 'Popularity'
    $('.request').tsort('.me-too-count',{order:'desc', data:'count'}, '.timeago', {order:'asc', data:'timestamp'})
  else if sort_type == 'Time'
    $('.request').tsort('.timeago',{order:'asc', data:'timestamp'})