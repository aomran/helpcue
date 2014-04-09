@HelpCue.RequestsList =

  updateList: (data) ->
    if data.helpStatus == true
      @addRequest(data.requesterPartial)
    else
      @removeRequest(data.requesterId)

  addRequest: (partial) ->
    $placeholder = $('#placeholder')
    $placeholder.hide() if $placeholder.length
    $('#requests-table').append(partial)
    $('.timeago').each ->
      $this = $(this)
      if $this.data('active') != 'yes'
        $this.timeago().data('active','yes')

  removeRequest: (requestId) ->
    $("#request#{requestId}").fadeOut 'slow', ->
      $(this).remove()
      unless $('.request').length
        $('#placeholder').show()