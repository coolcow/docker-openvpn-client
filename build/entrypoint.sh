#!/bin/sh

set -e

export TARGET_UID=${OPENVPN_UID:-1000}
export TARGET_GID=${OPENVPN_GID:-1000}
export TARGET_REMAP_IDS=${OPENVPN_REMAP_IDS:-1}
export TARGET_USER=${OPENVPN_USER:-openvpn}
export TARGET_GROUP=${OPENVPN_GROUP:-openvpn}
export TARGET_HOME=${OPENVPN_HOME:-/home/openvpn}
export TARGET_SHELL=${OPENVPN_SHELL:-/bin/sh}

exec /usr/local/bin/entrypoint_su-exec.sh openvpn "$@"