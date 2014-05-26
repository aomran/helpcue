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
    HelpCue.tinysort()

    $('.sort-by-popularity').on "ajax:success", (e, data) ->
      $('.request').tsort('.me-too-count',{order:'desc', data:'count'}, '.timeago', {order:'asc', data:'timestamp'})
      $(this).addClass('active')
      $('.sort-by-time').removeClass('active')

    $('.sort-by-time').on "ajax:success", (e, data) ->
      $('.request').tsort('.timeago',{order:'asc', data:'timestamp'})
      $(this).addClass('active')
      $('.sort-by-popularity').removeClass('active')
