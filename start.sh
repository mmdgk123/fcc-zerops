#!/bin/bash
set -x
cd /var/www
export PATH="/var/www/pfx/bin:${PATH}"
export PYTHONPATH="$(echo /var/www/pfx/lib/python*/site-packages | tr ' ' ':'):${PYTHONPATH:-}"
# FCC snapshots process env into ~/.fcc/.env on first boot and keeps it;
# wipe it so fresh Zerops user-data envs (keys, MODEL, proxy token) always apply.
rm -rf "$HOME/.fcc/.env" "$HOME/.fcc/config.lock" 2>/dev/null || true
ls /var/www/pfx/bin/ | head
exec fcc-server
