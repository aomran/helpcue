if Rails.env.production?
  MessageBus.configure(backend: :redis, url: ENV["REDISCLOUD_URL"])
end
