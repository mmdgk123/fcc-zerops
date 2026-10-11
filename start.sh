#!/bin/bash
# FCC reads ANTHROPIC_AUTH_TOKEN only from ~/.fcc/.env (managed file),
# NOT from process env — so seed the managed file from Zerops user-data first.
mkdir -p "$HOME/.fcc" 2>/dev/null || true
if [ -n "$ANTHROPIC_AUTH_TOKEN" ]; then
  printf 'ANTHROPIC_AUTH_TOKEN=%s\nPROXY_AUTH_ENABLED=%s\n' "$ANTHROPIC_AUTH_TOKEN" "${PROXY_AUTH_ENABLED:-true}" > "$HOME/.fcc/.env"
  chmod 600 "$HOME/.fcc/.env" 2>/dev/null || true
fi
if [ -n "$GEMINI_API_KEY" ] && ! grep -q "^GEMINI_API_KEY=" "$HOME/.fcc/.env" 2>/dev/null; then
  printf 'GEMINI_API_KEY=%s\n' "$GEMINI_API_KEY" >> "$HOME/.fcc/.env"
fi
if [ -n "$MODEL" ] && ! grep -q "^MODEL=" "$HOME/.fcc/.env" 2>/dev/null; then
  printf 'MODEL=%s\n' "$MODEL" >> "$HOME/.fcc/.env"
fi
if [ -n "$OPENCODE_API_KEY" ] && ! grep -q "^OPENCODE_API_KEY=" "$HOME/.fcc/.env" 2>/dev/null; then
  printf 'OPENCODE_API_KEY=%s\n' "$OPENCODE_API_KEY" >> "$HOME/.fcc/.env"
fi
export PYTHONPATH="/var/www/vendor:${PYTHONPATH:-}"
export PATH="/var/www/vendor/bin:$HOME/.fccvendor/bin:${PATH}"
if ! command -v fcc-server >/dev/null 2>&1; then
  pip install --no-cache-dir --target="$HOME/.fccvendor" --ignore-requires-python free-claude-code
  export PYTHONPATH="$HOME/.fccvendor:${PYTHONPATH}"
  export PATH="$HOME/.fccvendor/bin:${PATH}"
fi
exec fcc-server
