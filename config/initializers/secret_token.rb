# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Helpcue::Application.config.secret_key_base = if Rails.env.development? or Rails.env.test?
  'd6da02da5ba477e2e9e14e4576a8e90f11e939c329f0ac655a04a0ddb7c85a73aeb4cd92496251d1e98fcda6116b24844a9414aa1342cba5c265595da2630cf0'
else
  ENV['SECRET_TOKEN']
end
