$ = jQuery

$ ->
  if $('#classrooms').length
    $('#new_classroom').on "ajax:success", (e, data, status, xhr) ->
      HelpCue.clear_modal()
      $('#classrooms').append($(data.partial).fadeIn('slow'))
      analytics.track "User created classroom", classroom_id: data.id

    $('#new_classroom').on "ajax:error", (e, xhr, status, error) ->
      HelpCue.form_validations('classroom', JSON.parse(xhr.responseText))

    $('#join_classroom').on "ajax:success", (e, data, status, xhr) ->
      HelpCue.clear_modal()
      $('.grid-unit').last().after($(data.partial).fadeIn('slow'))
      analytics.track "User joined classroom", classroom_id: data.id, role: data.role

    $('#join_classroom').on "ajax:error", (e, xhr, status, error) ->
      HelpCue.form_validations('join', {token: xhr.responseText})

