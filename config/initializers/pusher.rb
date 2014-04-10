require 'pusher'

unless Rails.env.production?
  Pusher.app_id = '71476'
  Pusher.key = '25d54724919c414f290a'
  Pusher.secret = '8eb4b18291b92b3c0a6a'
end