@HelpCue.RequestsList =

  requestPath: (classroom_id, request_id) ->
    "/classrooms/#{classroom_id}/requests/#{request_id}"

  updateRequest: (data) ->
    request_id = data.request_id
    $request = $("#request#{request_id}")
    $.getJSON @requestPath(data.classroom_id, data.request_id), (data) ->
      $request.replaceWith(data.partial)
      $("#request#{request_id} .question-content").effect('highlight', {color: '#E8FFE7'}, 500)
      HelpCue.timeago()
      $(".rest-in-place").restInPlace()

  addRequest: (data) ->
    $placeholder = $('#placeholder')
    $placeholder.hide() if $placeholder.length
    $.getJSON @requestPath(data.classroom_id, data.request_id), (data) ->
      $('#requests-list').append(data.partial)
      HelpCue.timeago()
      $(".rest-in-place").restInPlace()

  removeRequest: (data) ->
    $("#request#{data.request_id}").fadeOut 'slow', ->
      $(this).remove()
      unless $('.request-item').length
        $('#placeholder').show()

  realtimeRequests: (data) ->
    HelpCue.RequestsList[data.requestAction](data)