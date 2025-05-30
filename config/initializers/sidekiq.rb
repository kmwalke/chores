Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', nil), size: 1, network_timeout: 5 }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', nil), size: 12, network_timeout: 5 }
end

# Sidekiq::Extensions.enable_delay!

# schedule_file = 'config/schedule.yml'

# Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?
