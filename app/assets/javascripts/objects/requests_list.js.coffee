@HelpCue.RequestsList =

  updateRequest: (data) ->
    request_id = data.request_id
    $request = $("#request#{request_id}")
    $.getJSON data.path, (data) ->
      $request.replaceWith(data.partial)
      $("#request#{request_id} .question-content").effect('highlight')
      HelpCue.timeago()

  addRequest: (data) ->
    $placeholder = $('#placeholder')
    $placeholder.hide() if $placeholder.length
    $.getJSON data.path, (data) ->
      $('#requests-list').append(data.partial)
      HelpCue.timeago()

  removeRequest: (data) ->
    $("#request#{data.request_id}").fadeOut 'slow', ->
      $(this).remove()
      unless $('.request').length
        $('#placeholder').show()

  realtimeRequests: (data) ->
    HelpCue.RequestsList[data.requestAction](data)