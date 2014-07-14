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
        HelpCue.tinysort()
        HelpCue.hashTag()

  addRequest: (data) ->
    $placeholder = $('#placeholder')
    $placeholder.addClass('dont-show') if $placeholder.length
    $.getJSON @requestPath(data.classroom_id, data.request_id), (data) ->
      $('#requests-list').append(data.partial).append(data.expand_partial)
      HelpCue.timeago()
      HelpCue.editable()
      HelpCue.hashTag()

  removeRequest: (data) ->
    $("#request#{data.request_id}").fadeOut 'slow', ->
      $(this).remove()
      unless $('.request-item').length
        $('#placeholder').removeClass('dont-show')

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
      $("#request#{data.request_id} .answer-false").attr('title', "Click 'More' to see answer").removeClass('answer-false').addClass('answer-true')
    else
      $("#request#{data.request_id} .answer-true").attr('title', 'No answer entered').removeClass('answer-true').addClass('answer-false')
      data.answer = "<p class='lightgrey-text'> No answer yet </p>"

    $request_modal = $("#request-expand-#{data.request_id}")
    if $request_modal.find(".editable.answer").length
      $request_modal.find(".editable.answer").editable('setValue', data.answer)
    else
      $request_modal.find(".answer").html(data.answer)

  updateSort: (data) ->
    $sort_el = $('#sort-type')
    $sort_el.html("<p>Sort: <strong>#{data.sortType}</strong>") unless $sort_el.find('a').length
    HelpCue.tinysort({sortType: data.sortType})

  realtimeRequests: (data) ->
    HelpCue.RequestsList[data.requestAction](data)