web: bundle exec puma -t ${PUMA_MIN_THREADS:-16}:${PUMA_MAX_THREADS:-16} -w ${PUMA_WORKERS:-3} -p $PORT -e ${RACK_ENV:-development}
worker: bundle exec sidekiq