#!/bin/bash
set -x
export PYTHONPATH="/var/www/vendor:${PYTHONPATH:-}"
export PATH="/var/www/vendor/bin:${PATH}"
exec fcc-server
