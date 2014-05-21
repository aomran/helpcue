$ = jQuery

$ ->
  if $('#classrooms').length
    $('#new_classroom').on "ajax:success", (e, data, status, xhr) ->
      HelpCue.clear_modal()
      $('#classrooms').append($(data.partial).fadeIn('slow'))
      $('.placeholder').hide()
      analytics.track "User created classroom", classroom_id: data.id
      Intercom('trackEvent', 'created-classroom', {classroom_id: data.id})

    $('#new_classroom').on "ajax:error", (e, xhr, status, error) ->
      HelpCue.form_validations('classroom', JSON.parse(xhr.responseText))

    $('#join_classroom').on "ajax:success", (e, data, status, xhr) ->
      HelpCue.clear_modal()
      $('#classrooms').append($(data.partial).fadeIn('slow'))
      $('.placeholder').hide()
      analytics.track "User joined classroom", classroom_id: data.id
      Intercom('trackEvent', 'joined-classroom', { classroom_id: data.id })

    $('#join_classroom').on "ajax:error", (e, xhr, status, error) ->
      HelpCue.form_validations('join', {token: xhr.responseText})

  # Realtime
  if $('#queue_link').length
    HelpCue.channel ?= HelpCue.pusher.subscribe("classroom#{$('#queue_link').data('classroomid')}-requests")

    HelpCue.channel.bind 'requestUpdate', (data) ->
      HelpCue.RequestsNumber.update(data)

    HelpCue.channel.bind 'request', (data) ->
      if (data.user_id != HelpCue.user.id)
        HelpCue.RequestsList.realtimeRequests(data)