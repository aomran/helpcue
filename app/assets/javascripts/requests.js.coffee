$ = jQuery

$ ->
  if $('#requests-table').length
    $('#new_request').on "ajax:success", (e, data) ->
      $(this).find('#request_question').val('')

    $("abbr.timeago").timeago()

    $('#requests-table').on 'click', '.me-too-count', ->
      $(this).closest('td').find('.me-too-people').toggle()