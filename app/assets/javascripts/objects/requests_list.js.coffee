@HelpCue.RequestsList =

  updateRequest: (data) ->
    $("#request#{data.request_id}").replaceWith(data.partial)
    HelpCue.timeago()

  addRequest: (partial) ->
    $placeholder = $('#placeholder')
    $placeholder.hide() if $placeholder.length
    $('#requests-table').append(partial)
    HelpCue.timeago()

  removeRequest: (requestId) ->
    $("#request#{requestId}").fadeOut 'slow', ->
      $(this).remove()
      unless $('.request').length
        $('#placeholder').show()