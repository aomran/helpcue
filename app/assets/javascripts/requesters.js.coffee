$ = jQuery

$ ->
  if $('#requesters-table').length
    # Add request
    $('#new_request').on "ajax:success", (e, data) ->
      HelpCue.RequestsList.addRequest(data.partial)

    # Remove student from help queue
    # $('#requesters-table').on "ajax:success", '.btn-small', (e, data) ->
    #   HelpCue.RequestsList.removeRequest(data.id)
    #   analytics.track "Teacher Answered Student", classroom_id: data.classroom_id