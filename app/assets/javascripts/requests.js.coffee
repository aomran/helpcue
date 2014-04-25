$ = jQuery

$ ->
  if $('#requests-list').length
    $('#new_request').on "ajax:success", (e, data) ->
      HelpCue.RequestsList.addRequest(data)
      $(this).find('#request_question').val('')
      analytics.track "Request created", classroom_id: data.classroom_id, request_id: data.request_id, question_length: data.question_length
      Intercom('trackEvent', 'created-request', {classroom_id: data.classroom_id, request_id: data.request_id, question_length: data.question_length})

    HelpCue.timeago()

  if $('#completed-requests').length
    analytics.track "Viewed completed requests page", classroom_id: $('#track_link').data('classroomid')
    Intercom('trackEvent', 'viewed-completed-request', {classroom_id: $('#track_link').data('classroomid')})

  if $('.requests').length

    $('.requests-container').on 'ajax:success', '.pagination a', (e, data) ->
      $('#requests').html(data.partial)
      $('#pagination').html(data.pagination_partial)

    $requests = $('.requests')

    $requests.on 'click', '.me-too-count', ->
      $(this).closest('.request').find('.me-too-people').toggle()


    $requests.on 'ajax:success', '.request-toggle', (e, data) ->
      HelpCue.RequestsList.updateRequest(data)
      if data.request_status == 'Being Helped'
        analytics.track "Request being processed", classroom_id: data.classroom_id, request_id: data.request_id, waiting_time: data.waiting_time
        Intercom('trackEvent', 'request-being-processed', {classroom_id: data.classroom_id, request_id: data.request_id, waiting_time: data.waiting_time})


    $requests.on 'ajax:success', '.request-remove', (e, data) ->
      HelpCue.RequestsList.removeRequest(data)
      analytics.track "Request done", classroom_id: data.classroom_id, request_id: data.request_id
      Intercom('trackEvent', 'request-done', {classroom_id: data.classroom_id, request_id: data.request_id})

    $requests.on 'ajax:success', '.request-delete', (e, data) ->
      HelpCue.RequestsList.removeRequest(data)
      analytics.track "Request deleted", classroom_id: data.classroom_id, request_id: data.request_id
      Intercom('trackEvent', 'request-deleted', {classroom_id: data.classroom_id, request_id: data.request_id})

    $requests.on 'ajax:success', '.request-metoo', (e, data) ->
      HelpCue.RequestsList.updateRequest(data)
      if data.me_too_status == 'joined'
        analytics.track "User joins a request", classroom_id: data.classroom_id, request_id: data.request_id, count: data.count
        Intercom('trackEvent', 'joined-request', {classroom_id: data.classroom_id, request_id: data.request_id, count: data.count})
      else if data.me_too_status == 'left'
        analytics.track "User leaves a request", classroom_id: data.classroom_id, request_id: data.request_id, count: data.count
        Intercom('trackEvent', 'left-request', {classroom_id: data.classroom_id, request_id: data.request_id, count: data.count})