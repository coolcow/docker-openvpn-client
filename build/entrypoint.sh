#!/bin/sh

set -e

# Default behavior: run OpenVPN directly as root.
# Optional behavior: if PUID/PGID are provided, switch to that user via shared entrypoint scripts.
if [ -n "${PUID}" ] || [ -n "${PGID}" ]; then
  exec /usr/local/bin/entrypoint_su-exec.sh openvpn "$@"
fi

exec openvpn "$@"