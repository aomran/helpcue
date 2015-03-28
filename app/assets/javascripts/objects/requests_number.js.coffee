@HelpCue.RequestsNumber =
  update: (requestAction) ->
    $queueLink = $('#queue_link')
    reqLimit = $queueLink.data("reqlimit")
    oldReqNum = $queueLink.data("requests")
    newReqNum = @updateNumber(oldReqNum, requestAction)

    # Reset title & text
    document.title = document.title.replace(/\(\d+\+*\)\s/, '')
    $queueLabel = $queueLink.find('.requests-badge')
    $queueLabel.text($queueLabel.text().replace(/\d+/, '')).hide()

    # Update the DOM data
    $queueLink.data("requests", newReqNum)

    # Update the visual
    if newReqNum > 0
      newReqNum = '30+' if newReqNum > reqLimit
      document.title = "(#{newReqNum}) #{document.title}"
      $queueLabel.text(newReqNum).removeClass('dont-show').show()

  updateNumber: (oldReqNum, requestAction) ->
    if requestAction == 'addRequest'
      return oldReqNum + 1
    else if requestAction == 'removeRequest'
      return oldReqNum - 1
