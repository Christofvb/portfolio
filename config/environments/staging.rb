require "active_support/core_ext/integer/time"

# Staging = production-like mais avec erreurs visibles et logs verbeux.
Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true

  # Afficher les erreurs complètes (contrairement à la prod)
  config.consider_all_requests_local = true

  config.action_controller.perform_caching = true
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.day.to_i}" }

  config.active_storage.service = :local

  config.assume_ssl = true
  config.force_ssl  = true

  config.log_tags = [ :request_id ]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "debug")

  config.silence_healthcheck_path = "/up"
  config.active_support.report_deprecations = false

  config.cache_store = :solid_cache_store
  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = { database: { writing: :queue } }

  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = { host: "staging.cvb-dev.fr" }

  config.i18n.fallbacks = true
  config.active_record.dump_schema_after_migration = false
end
