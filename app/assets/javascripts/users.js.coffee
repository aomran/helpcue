$ = jQuery

$ ->
  if $('.users-table').length
    $('.users-table').on "ajax:success", '.user-remove', (e, data, status, xhr) ->
      $("#user_#{data.id}").fadeOut 'slow', ->
        $(this).remove()

    $('.users-table').on "ajax:success", '.user-promote-form', (e, data, status, xhr) ->
      $("#user_#{data.id} .role").text(data.role)