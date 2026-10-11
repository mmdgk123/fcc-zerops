#!/bin/bash
set -x
export PYTHONPATH="/var/www/vendor:${PYTHONPATH:-}"
export PATH="/var/www/vendor/bin:${PATH}"
if ! command -v fcc-server >/dev/null 2>&1; then
  echo "fcc-server missing, installing at runtime..."
  pip install --no-cache-dir --target="$HOME/.fccvendor" --ignore-requires-python free-claude-code
  export PYTHONPATH="$HOME/.fccvendor:${PYTHONPATH}"
  export PATH="$HOME/.fccvendor/bin:${PATH}"
  which fcc-server
fi
# FCC snapshots process env into ~/.fcc/.env on first boot and keeps it;
# wipe it so fresh Zerops user-data envs (keys, MODEL, proxy token) always apply.
rm -rf "$HOME/.fcc/.env" "$HOME/.fcc/config.lock" 2>/dev/null || true
exec fcc-server
