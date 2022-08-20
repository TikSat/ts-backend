#!/bin/bash

trap "echo Exited!; exit;" SIGINT SIGTERM
trap "exit" TERM INT QUIT
trap "exit" EXIT

stringContain() { [ -z "${2##*$1*}" ]; }

# If cli, run and exit
if stringContain "rake" $@ || stringContain "bash" $@; then
  exec $@
  exit
fi

set -e

until nc -z "$POSTGRES_HOST" "$POSTGRES_PORT"; do
  echo "Waiting for Database (Error when connecting to $POSTGRES_HOST:"$POSTGRES_PORT")"
  sleep 3
done

echo 'Preparing Backend'

if ! stringContain "master" "$RUN_ENV"; then
  bundle exec rake db:create
fi

bundle exec rake db:migrate

if ! stringContain "master" "$RUN_ENV"; then
  bundle exec rake db:seed
fi

# Run original command
echo 'Starting Backend'
exec $@
