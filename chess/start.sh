#!/bin/bash

export MIX_ENV=prod
export PORT=4431

echo "Starting app..."

# Start to run in background from shell.
_build/prod/rel/chess/bin/chess stop || true

# Foreground for testing and for systemd
_build/prod/rel/chess/bin/chess start

# TODO: Add a systemd service file
#       to start your app on system boot.
