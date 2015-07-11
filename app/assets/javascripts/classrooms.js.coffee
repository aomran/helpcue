$ = jQuery

$ ->
  if $('#classrooms').length
    $('#new_classroom').on "ajax:success", (e, data, status, xhr) ->
      HelpCue.clear_modal()
      $('#classrooms').append($(data.partial).fadeIn('slow'))
      $('.placeholder').hide()
      analytics.track "User created classroom", classroom_id: data.id

    $('#new_classroom').on "ajax:error", (e, xhr, status, error) ->
      HelpCue.form_validations('classroom', JSON.parse(xhr.responseText))

    $('#join_classroom').on "ajax:success", (e, data, status, xhr) ->
      HelpCue.clear_modal()
      $('#classrooms').append($(data.partial).fadeIn('slow'))
      $('.placeholder').hide()
      analytics.track "User joined classroom", classroom_id: data.id

    $('#join_classroom').on "ajax:error", (e, xhr, status, error) ->
      HelpCue.form_validations('join', {token: xhr.responseText})

    $('#classrooms').on "ajax:success", '.edit_classroom', (e, data, status, xhr) ->
      HelpCue.clear_modal()
      $("#classroom#{data.id}").replaceWith($(data.partial))

    $('#classrooms').on "ajax:error", '.edit_classroom', (e, xhr, status, error) ->
      HelpCue.form_validations('classroom', JSON.parse(xhr.responseText))

    $('#classrooms').on "ajax:success", '.leave_classroom', (e, data, status, xhr) ->
      $("#classroom#{data.id}").fadeOut 'slow', ->
        $(this).remove()
        unless $('.classroom').length
          $('#placeholder').removeClass('dont-show')

  # Realtime
  if $('#queue_link').length
    MessageBus.start()
    MessageBus.callbackInterval = 500
    MessageBus.alwaysLongPoll = true
    MessageBus.subscribe '/request', (data) ->
      if (data.user_id != HelpCue.user.id)
        HelpCue.RequestsList.realtimeRequests(data)
      if data.requestAction == 'addRequest' || data.requestAction == 'removeRequest'
        HelpCue.RequestsNumber.update(data.requestAction)
