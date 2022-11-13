#!/bin/bash
set -e

if [ -f ./db/development.sqlite3 ]; then
  rm ./db/development*
fi

# Restore the database
litestream restore -v -if-replica-exists -o ./db/development.sqlite3 gcs://blog-litestream

# Run litestream with your app as the subprocess.
RAILS_PORT=8080
if [ -n "$PORT" ]; then
  RAILS_PORT=$PORT
fi
exec litestream replicate -exec "rails server -p ${RAILS_PORT} -b 0.0.0.0"