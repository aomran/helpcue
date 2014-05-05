$ = jQuery

$ ->
  if $('#completed-requests').length
    analytics.track "Viewed completed requests page", classroom_id: $('#track_link').data('classroomid')
    Intercom('trackEvent', 'viewed-completed-request', {classroom_id: $('#track_link').data('classroomid')})

  if $('.requests-container').length
    $('.requests-container').on 'ajax:success', '.pagination a', (e, data) ->
      $('#requests').html(data.partial)
      $('#pagination').html(data.pagination_partial)