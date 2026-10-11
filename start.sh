#!/bin/bash
set -x
export PATH="/var/www/.local/bin:${PATH}"
export PYTHONPATH="/var/www/.local/lib/python3.14/site-packages:${PYTHONPATH:-}"
# FCC snapshots process env into ~/.fcc/.env on first boot and keeps it;
# wipe it so fresh Zerops user-data envs (keys, MODEL, proxy token) always apply.
rm -rf "$HOME/.fcc/.env" "$HOME/.fcc/config.lock" 2>/dev/null || true
exec fcc-server
