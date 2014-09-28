@HelpCue.Notifications = 
	notify: (message) ->
	  if Notification.permission is "granted"
	    notification = new Notification(message)

	askPermission: ->
	  Notification.requestPermission (permission) ->
	    Notification.permission = permission  unless "permission" of Notification
	    HelpCue.Notifications.setupPermission()

	 setupPermission: ->
    if Notification.permission is "granted"
      $('#ask_permission').text('Notifications (On)')
    else
      $('#ask_permission').html('<a href="#">Notifications (Off)</a>')