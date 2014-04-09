$ = jQuery

$ ->
  if $('#requests-table').length
    # Add request
    $('#new_request').on "ajax:success", (e, data) ->
      HelpCue.RequestsList.addRequest(data.partial)
      $(this).find('#request_question').val('')

    $('#requests-table').on 'ajax:success', '.request-button', (e, data) ->
      $(this).toggleClass('btn-primary btn-success')
      $(this).closest('td').find('.request-remove').toggle()

    $('#requests-table').on 'ajax:success', '.request-remove', (e, data) ->
      HelpCue.RequestsList.removeRequest(data.request_id)

    $('#requests-table').on 'ajax:success', '.request-delete', (e, data) ->
      HelpCue.RequestsList.removeRequest(data.id)

    $("abbr.timeago").timeago()