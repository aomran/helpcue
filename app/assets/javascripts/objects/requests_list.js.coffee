# @Curri.RequestsList =

#   updateList: (data) ->
#     if data.helpStatus == true
#       @addRequest(data.requesterPartial)
#     else
#       @removeRequest(data.requesterId)

#   addRequest: (partial) ->
#     $placeholder = $('#placeholder')
#     $placeholder.remove() if $placeholder.length
#     $('#requesters-table').append(partial)
#     @hideButtons()

#   removeRequest: (requesterId) ->
#     $("#requester#{requesterId}").fadeOut 'slow', ->
#       $(this).remove()
#       unless $('.requester').length
#         $('#requesters-table').append('<tr id="placeholder"><td colspan="4">No students need help right now.</td></tr>')

#   hideButtons: ->
#     if Curri.user.classrole_type == 'Student'
#       $('.request-button').parent('td').hide()