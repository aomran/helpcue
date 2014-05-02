$ = jQuery

$ ->
  if $('#requests-list').length
    $('#new_request').on "ajax:success", (e, data) ->
      $.when(HelpCue.RequestsList.addRequest(data)).then ->
        $('#request_question').val('')
        window.scrollTo(0,document.body.scrollHeight)

      analytics.track "Request created", classroom_id: data.classroom_id, request_id: data.request_id, question_length: data.question_length
      Intercom('trackEvent', 'created-request', {classroom_id: data.classroom_id, request_id: data.request_id, question_length: data.question_length})

    HelpCue.timeago()