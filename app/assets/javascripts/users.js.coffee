$ = jQuery

$ ->
  if $('.users-table').length
    $('.users-table').on "ajax:success", '.user-remove', (e, data, status, xhr) ->
      $("#user_#{data.id}").fadeOut 'slow', ->
        $(this).remove()