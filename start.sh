#!/bin/bash
set -x
export PYTHONPATH="/var/www/vendor:${PYTHONPATH:-}"
export PATH="/var/www/vendor/bin:${PATH}"
# FCC snapshots process env into ~/.fcc/.env on first boot and keeps it;
# wipe it so fresh Zerops user-data envs (keys, MODEL, proxy token) always apply.
rm -rf "$HOME/.fcc/.env" "$HOME/.fcc/config.lock" 2>/dev/null || true
exec fcc-server
