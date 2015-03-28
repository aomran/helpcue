$ = jQuery

$ ->
  if $('.users-table').length
    $userTable = $('.users-table')

    $userTable.on "ajax:success", '.user-remove', (e, data, status, xhr) ->
      $("#user_#{data.id}").fadeOut 'slow', ->
        $(this).remove()

    $userTable.on "ajax:success", '.user-promote-form', (e, data, status, xhr) ->
      $("#user_#{data.id} .user-role").text(data.role)
