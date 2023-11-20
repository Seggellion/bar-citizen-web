#!/bin/bash
# start.sh4

echo "Debug: Content of GOOGLE_CREDENTIALS:"
echo "$GOOGLE_CREDENTIALS"

# Create the Google credentials file
echo "$GOOGLE_CREDENTIALS" > /app/google-credentials.json

# Set GOOGLE_APPLICATION_CREDENTIALS environment variable
# export GOOGLE_APPLICATION_CREDENTIALS=/app/google-credentials.json

# List files in /app directory for debugging
ls -l /app

rm -f tmp/pids/server.pid


# Start Rails Server
bundle exec rails s -p 3000 -b '0.0.0.0'