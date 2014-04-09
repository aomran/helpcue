@HelpCue.RequestsList =

  updateList: (data) ->
    if data.helpStatus == true
      @addRequest(data.requesterPartial)
    else
      @removeRequest(data.requesterId)

  addRequest: (partial) ->
    $placeholder = $('#placeholder')
    $placeholder.hide() if $placeholder.length
    $('#requesters-table').append(partial)

  removeRequest: (requestId) ->
    $("#request#{requestId}").fadeOut 'slow', ->
      $(this).remove()
      unless $('.request').length
        $('#placeholder').show()