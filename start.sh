#!/bin/bash
set -x
cd /var/www
if [ -d /var/www/vendor/bin ]; then
  export PATH="/var/www/vendor/bin:${PATH}"
  export PYTHONPATH="/var/www/vendor:${PYTHONPATH:-}"
elif [ -d /var/www/.venv/bin ]; then
  export PATH="/var/www/.venv/bin:${PATH}"
fi
ls /var/www/ | head -20
which fcc-server || find /var/www -maxdepth 4 -name "fcc-server" 2>/dev/null | head -n 3
# FCC snapshots process env into ~/.fcc/.env on first boot and keeps it;
# wipe it so fresh Zerops user-data envs (keys, MODEL, proxy token) always apply.
rm -rf "$HOME/.fcc/.env" "$HOME/.fcc/config.lock" 2>/dev/null || true
exec fcc-server
