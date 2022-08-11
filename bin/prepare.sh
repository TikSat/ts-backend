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

until nc -z "$POSTGRES_HOST" 5432; do
  echo "Waiting for Database (Error when connecting to $POSTGRES_HOST:5432)"
  sleep 3
done

echo 'Preparing Backend'
bundle exec rake db:create
bundle exec rake db:migrate

# Run original command
echo 'Starting Backend'
exec $@
