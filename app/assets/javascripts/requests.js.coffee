$ = jQuery

$ ->
  if $('#requests-list').length
    $('#new_request').on "ajax:success", (e, data) ->
      $(this).find('#request_question').val('')
      analytics.track "Request created", classroom_id: data.classroom_id, request_id: data.request_id

    HelpCue.timeago()

    $('#requests-list').on 'click', '.me-too-count', ->
      $(this).closest('.request').find('.me-too-people').toggle()


    $('#requests-list').on 'ajax:success', '.request-button', (e, data) ->
      if data.request_status == 'Being Helped'
        analytics.track "Request being processed", classroom_id: data.classroom_id, request_id: data.request_id


    $('#requests-list').on 'ajax:success', '.request-remove', (e, data) ->
      analytics.track "Request done", classroom_id: data.classroom_id, request_id: data.request_id

    $('#requests-list').on 'ajax:success', '.request-delete', (e, data) ->
      analytics.track "Request deleted", classroom_id: data.classroom_id, request_id: data.request_id

    $('#requests-list').on 'ajax:success', '.request-metoo', (e, data) ->
      if data.me_too_status == 'joined'
        analytics.track "User joins a request", classroom_id: data.classroom_id, request_id: data.request_id, count: data.count
      else if data.me_too_status == 'left'
        analytics.track "User leaves a request", classroom_id: data.classroom_id, request_id: data.request_id, count: data.count

  if $('#completed-requests').length
    analytics.track "Viewed completed requests page", classroom_id: $('#track_link').data('classroomid')