workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Reconnect to DB
  ActiveRecord::Base.establish_connection
  # Reconnect to Redis
  MessageBus.after_fork if defined?(MessageBus)
end
