if Rails.env.production?
  MessageBus.redis_config = { url: ENV["REDIS_URL"] }
end
