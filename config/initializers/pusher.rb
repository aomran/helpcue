require 'pusher'

unless Rails.env.production?
  Pusher.app_id = '63065'
  Pusher.key = 'a04c76daaec237bb1d36'
  Pusher.secret = '46e5b89679bead70002e'
end