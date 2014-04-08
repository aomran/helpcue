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

  removeRequest: (requesterId) ->
    $("#requester#{requesterId}").fadeOut 'slow', ->
      $(this).remove()
      unless $('.requester').length
        $$('#placeholder').show()