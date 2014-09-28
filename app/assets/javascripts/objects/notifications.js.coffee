@HelpCue.Notifications = 
	notify: ->
    if Notification.permission is "granted"
      time = new Date()
      message = "#{time.toLocaleTimeString()}: A new question was added to HelpCue!"
      notification = new Notification(message, {icon: '/assets/logo.png'})

	askPermission: ->
	  Notification.requestPermission (permission) ->
	    Notification.permission = permission  unless "permission" of Notification
	    HelpCue.Notifications.setupPermission()

	 setupPermission: ->
    if Notification.permission is "granted"
      $('#ask_permission').text('Notifications (On)')
    else
      $('#ask_permission').html('<a class="notify-on" href="#">Notifications (Off)</a>')