# @Curri.RequestsNumber =
#   update: (data) ->
#     $requestsLink = $('#requesters_link')
#     reqLimit = $requestsLink.data("reqlimit")
#     oldReqNum = $requestsLink.data("requests")
#     newReqNum = @updateNumber(oldReqNum, data.add)

#     # Reset title
#     document.title = document.title.replace(/\(\d+\)\s/, '')

#     # Update the DOM data
#     $requestsLink.data("requests", newReqNum)

#     # Update the visual
#     if newReqNum > 0
#       $('.nav-help').toggleClass('active', true)
#       $reqNumb = $('.req-num').show()
#       document.title = "(#{newReqNum}) #{document.title}"
#       if newReqNum <= reqLimit
#         $reqNumb.text(newReqNum)
#       else
#         $reqNumb.text(reqLimit + "+")
#     else
#       $('.req-num').hide()
#       $('.nav-help').removeClass('active')

#   updateNumber: (oldReqNum, add) ->
#     if add
#       return oldReqNum + 1
#     else
#       return oldReqNum - 1