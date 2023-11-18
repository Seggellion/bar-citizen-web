#!/bin/bash
# start.sh

# Start Webpack Dev Server in the background
# ./bin/dev &

rm -f tmp/pids/server.pid


# Start Rails Server
bundle exec rails s -p 3000 -b '0.0.0.0'