#!/bin/bash
# start.sh4



# Set GOOGLE_APPLICATION_CREDENTIALS environment variable
# export GOOGLE_APPLICATION_CREDENTIALS=/app/google-credentials.json
rm -f tmp/pids/server.pid


# Start Rails Server
bundle exec rails s -p 3000 -b '0.0.0.0'

exec "$@"

