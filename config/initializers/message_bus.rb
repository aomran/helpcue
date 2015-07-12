if Rails.env.production?
  MessageBus.redis_config = { url: ENV["REDISCLOUD_URL"] }
end
