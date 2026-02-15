# ghcr.io/coolcow/openvpn-client

Simple and minimal Alpine-based Docker image for OpenVPN client usage.

---

## Overview

This image provides the `openvpn` binary as container entrypoint and is intended to run client VPN sessions with your own `.ovpn` configuration.

---

## Usage

### Quick Start

```sh
docker run --rm ghcr.io/coolcow/openvpn-client
```

Default runtime behavior:

- **ENTRYPOINT:** `openvpn`
- **CMD:** `--help`

### Run with a Client Configuration

```sh
docker run --rm -it \
	--cap-add=NET_ADMIN \
	--device /dev/net/tun \
	-v <PATH_TO_CONFIG>:/vpn/client.ovpn:ro \
	ghcr.io/coolcow/openvpn-client \
		--config /vpn/client.ovpn
```

Replace `<PATH_TO_CONFIG>` with the path to your `.ovpn` file.

---

## References

- [OpenVPN Community Resources](https://openvpn.net/community-resources/)


