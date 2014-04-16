@HelpCue.RequestsNumber =
  update: (data) ->
    $queueLink = $('#queue_link')
    reqLimit = $queueLink.data("reqlimit")
    newReqNum = data.requests_count

    # Reset title & text
    document.title = document.title.replace(/\(\d+\)\s/, '')
    $queueLabel = $queueLink.find('.nav-label')
    $queueLabel.text($queueLabel.text().replace(/\s\(\d+\)/, ''))

    # Update the visual
    if newReqNum > 0
      newReqNum = '30+' if newReqNum > reqLimit
      document.title = "(#{newReqNum}) #{document.title}"
      $queueLabel.text("#{$queueLabel.text()} (#{newReqNum})")