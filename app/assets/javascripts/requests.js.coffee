$ = jQuery

$ ->
  if $('#requesters-table').length
    # Add request
    $('#new_request').on "ajax:success", (e, data) ->
      HelpCue.RequestsList.addRequest(data.partial)


    $('.edit_request select').on 'change', ->
      $(this).closest('form').submit()
    # Remove student from help queue
    # $('#requesters-table').on "ajax:success", '.btn-small', (e, data) ->
    #   HelpCue.RequestsList.removeRequest(data.id)
    #   analytics.track "Teacher Answered Student", classroom_id: data.classroom_id