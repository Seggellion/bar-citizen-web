#!/bin/sh

#echo "Generating google-credentials.json from Heroku environment variable"

printf "%s" "$GOOGLE_CREDENTIALS" > google-credentials.json


exec "$@"