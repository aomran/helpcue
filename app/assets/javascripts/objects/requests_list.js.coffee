@HelpCue.RequestsList =

  updateRequest: (data) ->
    $request = $("#request#{data.request_id}")
    $.getJSON data.path, (data) ->
      $request.replaceWith(data.partial)
      HelpCue.timeago()

  addRequest: (data) ->
    $placeholder = $('#placeholder')
    $placeholder.hide() if $placeholder.length
    $.getJSON data.path, (data) ->
      $('#requests-table').append(data.partial)
      HelpCue.timeago()

  removeRequest: (data) ->
    $("#request#{data.request_id}").fadeOut 'slow', ->
      $(this).remove()
      unless $('.request').length
        $('#placeholder').show()

  realtimeRequests: (data) ->
    HelpCue.RequestsList[data.requestAction](data)