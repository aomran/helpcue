$ = jQuery

$ ->
  if $('.requests').length
    $requests = $('.requests')

    $requests.on 'click', '.me-too-count', ->
      $(this).closest('.request').find('.me-too-people').toggleClass('dont-show')

    $requests.on 'ajax:success', '.request-toggle', (e, data) ->
      HelpCue.RequestsList.updateRequest(data)
      if data.request_state == 1
        analytics.track "Request being processed", classroom_id: data.classroom_id, request_id: data.request_id, waiting_time: data.waiting_time

    $requests.on 'ajax:success', '.request-remove', (e, data) ->
      HelpCue.RequestsList.removeRequest(data)
      analytics.track "Request done", classroom_id: data.classroom_id, request_id: data.request_id

    $requests.on 'ajax:success', '.request-delete', (e, data) ->
      HelpCue.RequestsList.removeRequest(data)
      analytics.track "Request deleted", classroom_id: data.classroom_id, request_id: data.request_id

    $requests.on 'ajax:success', '.request-metoo', (e, data) ->
      HelpCue.RequestsList.updateRequest(data)
      analytics.track "User joins/leaves a request", classroom_id: data.classroom_id, request_id: data.request_id


    # x-editable
    $.fn.editable.defaults.mode = 'inline'
    $.fn.editable.defaults.showbuttons = 'bottom'
    $.fn.editableform.buttons = '<button type="submit" class="editable-submit btn btn-small btn-success">Save</button>'+
    'or <a href="#" class="editable-cancel">cancel</a>'
    HelpCue.editable()
    HelpCue.hashTag()
