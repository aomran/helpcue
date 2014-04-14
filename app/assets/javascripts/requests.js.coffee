$ = jQuery

$ ->
  if $('#requests-list').length
    $('#new_request').on "ajax:success", (e, data) ->
      HelpCue.RequestsList.addRequest(data)
      $(this).find('#request_question').val('')
      analytics.track "Request created", classroom_id: data.classroom_id, request_id: data.request_id

    HelpCue.timeago()

  if $('#completed-requests').length
    analytics.track "Viewed completed requests page", classroom_id: $('#track_link').data('classroomid')

  if $('.requests').length
    $requests = $('.requests')

    $requests.on 'click', '.me-too-count', ->
      $(this).closest('.request').find('.me-too-people').toggle()

    $requests.on 'ajax:success', '.request-toggle', (e, data) ->
      HelpCue.RequestsList.updateRequest(data)
      if data.request_status == 'Being Helped'
        analytics.track "Request being processed", classroom_id: data.classroom_id, request_id: data.request_id

    $requests.on 'ajax:success', '.request-remove', (e, data) ->
      HelpCue.RequestsList.removeRequest(data)
      analytics.track "Request done", classroom_id: data.classroom_id, request_id: data.request_id

    $requests.on 'ajax:success', '.request-delete', (e, data) ->
      HelpCue.RequestsList.removeRequest(data)
      analytics.track "Request deleted", classroom_id: data.classroom_id, request_id: data.request_id

    $requests.on 'ajax:success', '.request-metoo', (e, data) ->
      HelpCue.RequestsList.updateRequest(data)
      if data.me_too_status == 'joined'
        analytics.track "User joins a request", classroom_id: data.classroom_id, request_id: data.request_id, count: data.count
      else if data.me_too_status == 'left'
        analytics.track "User leaves a request", classroom_id: data.classroom_id, request_id: data.request_id, count: data.count

    $requests.on 'focusin', '[contenteditable="true"]', ->
      localStorage.setItem('originalText', $(this).html())

    # $requests.on 'focusout', '[contenteditable="true"]', ->
    #   localStorage.clear()

    $requests.on 'keydown', '[contenteditable="true"]', (e) ->
      if e.which == 27
        e.preventDefault()
        $(this).html(localStorage.getItem('originalText'))
        $(this).trigger('blur')
      else if e.which == 13
        e.preventDefault()
        linkHashtags($(this))
        $(this).trigger('blur')