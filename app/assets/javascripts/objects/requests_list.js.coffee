@HelpCue.RequestsList =

  requestPath: (classroom_id, request_id) ->
    "/classrooms/#{classroom_id}/requests/#{request_id}"

  updateRequest: (data) ->
    request_id = data.request_id
    $request = $("#request#{request_id}")
    $.ajax
      url: @requestPath(data.classroom_id, data.request_id)
      dataType: 'json'
      success: (data) ->
        $request.replaceWith(data.partial)
        $("#request#{request_id} .question-content").effect('highlight', {color: '#E8FFE7'}, 500)
      complete: ->
        HelpCue.timeago()
        HelpCue.editable()

  addRequest: (data) ->
    $placeholder = $('#placeholder')
    $placeholder.hide() if $placeholder.length
    $.getJSON @requestPath(data.classroom_id, data.request_id), (data) ->
      $('#requests-list').append(data.partial).append(data.expand_partial)
      HelpCue.timeago()
      HelpCue.editable()

  removeRequest: (data) ->
    $("#request#{data.request_id}").fadeOut 'slow', ->
      $(this).remove()
      unless $('.request-item').length
        $('#placeholder').show()

  updateQuestion: (data) ->
    data.question = "<p class='lightgrey-text'> Blank question </p>" unless data.question
    $("#request#{data.request_id}").find("div.question").html(HelpCue.linkHashtags(data))
    $request_modal = $("#request-expand-#{data.request_id}")
    if $request_modal.find(".editable.question").length
      $request_modal.find(".editable.question").editable('setValue', data.question)
    else
      $request_modal.find(".question").html(data.question)

  updateAnswer: (data) ->
    if data.answer
      $("#request#{data.request_id} .no-answer").attr('title', 'Click more icon to see answer').removeClass('no-answer').addClass('has-answer')
    else
      $("#request#{data.request_id} .has-answer").attr('title', 'No answer entered').removeClass('has-answer').addClass('no-answer')
      data.answer = "<p class='lightgrey-text'> No answer yet </p>"

    $request_modal = $("#request-expand-#{data.request_id}")
    if $request_modal.find(".editable.answer").length
      $request_modal.find(".editable.answer").editable('setValue', data.answer)
    else
      $request_modal.find(".answer").html(data.answer)


  realtimeRequests: (data) ->
    HelpCue.RequestsList[data.requestAction](data)