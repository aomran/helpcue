$ = jQuery

$ ->
  if $('#requests-list').length
    $('#new_request').on "ajax:success", (e, data) ->
      $.when(HelpCue.RequestsList.addRequest(data)).then ->
        $('#request_question').val('')
        window.scrollTo(0,document.body.scrollHeight)
        $("#request#{data.request_id} .question-content").effect('highlight', {color: '#E8FFE7'}, 500)
      analytics.track "Request created", classroom_id: data.classroom_id, request_id: data.request_id, question_length: data.question_length
      Intercom('trackEvent', 'created-request', {classroom_id: data.classroom_id, request_id: data.request_id, question_length: data.question_length})

    $('#request_question').on 'keydown', (e) ->
      if(e.keyCode == 13 && (e.metaKey || e.ctrlKey))
        $(this).parents('form').submit()

    if HelpCue.largeScreen()
      $(window).on 'scroll', ->
        if (document.body.scrollTop == 0)
          $('#new_request').css('top', '')
        else
          $('#new_request').css('top', '90px')

    HelpCue.timeago()

    # x-editable
    $.fn.editable.defaults.mode = 'inline'
    $.fn.editable.defaults.showbuttons = 'bottom'
    $.fn.editableform.buttons = '<button type="submit" class="editable-submit btn btn-small btn-success">Save</button>'+
    '<a href="#" class="editable-cancel">X</a>'
    $('.editable').editable(success: (response, newValue) -> HelpCue.RequestsList.updateQuestion(response))

    HelpCue.channel ?= HelpCue.pusher.subscribe("classroom#{$('#queue_link').data('classroomid')}-requests")
    HelpCue.channel.bind 'request', (data) ->
      if (data.user_id != HelpCue.user.id)
        HelpCue.RequestsList.realtimeRequests(data)
