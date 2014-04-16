@HelpCue.RequestsNumber =
  update: (data) ->
    $queueLink = $('#queue_link')
    reqLimit = $queueLink.data("reqlimit")
    oldReqNum = $queueLink.data("requests")
    newReqNum = @updateNumber(oldReqNum, data.add)

    # Reset title & text
    document.title = document.title.replace(/\(\d+\)\s/, '')
    $queueLabel = $queueLink.find('.nav-label')
    $queueLabel.text($queueLabel.text().replace(/\s\(\d+\)/, ''))

    # Update the DOM data
    $queueLink.data("requests", newReqNum)

    # Update the visual
    if newReqNum > 0
      newReqNum = '30+' if newReqNum > reqLimit
      document.title = "(#{newReqNum}) #{document.title}"
      $queueLabel.text("#{$queueLabel.text()} (#{newReqNum})")

  updateNumber: (oldReqNum, add) ->
    if add
      return oldReqNum + 1
    else
      return oldReqNum - 1