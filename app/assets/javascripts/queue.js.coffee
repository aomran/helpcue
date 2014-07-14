$ = jQuery

$ ->
  if $('#requests-list').length
    $('#new_request').on "ajax:success", (e, data) ->
      $.when(HelpCue.RequestsList.addRequest(data)).then ->
        $('#request_question').val('')
        $('.error-message').remove()
        window.scrollTo(0,document.body.scrollHeight)
        $("#request#{data.request_id} .question-content").effect('highlight', {color: '#E8FFE7'}, 500)
      analytics.track "Request created", classroom_id: data.classroom_id, request_id: data.request_id, question_length: data.question_length
      Intercom('trackEvent', 'created-request', {classroom_id: data.classroom_id, request_id: data.request_id, question_length: data.question_length})

    $('#new_request').on "ajax:error", (e, xhr, status, error) ->
      HelpCue.inline_form_validations('request', JSON.parse(xhr.responseText))

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
    HelpCue.tinysort()

    $('.sort-link').on "ajax:success", (e, data) ->
      HelpCue.tinysort({sortType: data.sort_type})
