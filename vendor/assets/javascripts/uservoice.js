if (window.HelpCue && window.HelpCue.user) {
  // Include the UserVoice JavaScript SDK (only needed once on a page)
  UserVoice=window.UserVoice||[];(function(){var uv=document.createElement('script');uv.type='text/javascript';uv.async=true;uv.src='//widget.uservoice.com/M4CpR1wjPuhXTx4ChPKA.js';var s=document.getElementsByTagName('script')[0];s.parentNode.insertBefore(uv,s)})();

  // Set colors
  UserVoice.push(['set', {
    accent_color: '#5DA3FD',
    trigger_color: 'white',
    trigger_background_color: '#5DA3FD'
  }]);

  // Identify the user and pass traits
  UserVoice.push(['identify', {
    email: window.HelpCue.user.email,
    name: window.HelpCue.user.first_name + " " + window.HelpCue.user.last_name,
    type: window.HelpCue.user.classrole_type
  }]);

  // Add default trigger to the bottom-right corner of the window:
  UserVoice.push(['addTrigger', { mode: 'satisfaction', trigger_position: 'bottom-right' }]);
}
