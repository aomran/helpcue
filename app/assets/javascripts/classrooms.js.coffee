$ = jQuery

$ ->
  if $('#classrooms').length
    $('#new_classroom').on "ajax:success", (e, data, status, xhr) ->
      HelpCue.clear_modal()
      $('.grid-unit').last().after($(data.partial).fadeIn('slow'))
      analytics.track "Teacher created classroom", classroom_id: data.id

    $('#new_classroom').on "ajax:error", (e, xhr, status, error) ->
      HelpCue.form_validations('classroom', JSON.parse(xhr.responseText))

    $('#join_classroom').on "ajax:success", (e, data, status, xhr) ->
      HelpCue.clear_modal()
      $('.grid-unit').last().after($(data.partial).fadeIn('slow'))
      analytics.track "Teacher joined classroom", classroom_id: data.id

    $('#join_classroom').on "ajax:error", (e, xhr, status, error) ->
      HelpCue.form_validations('teacher', {token: xhr.responseText})

