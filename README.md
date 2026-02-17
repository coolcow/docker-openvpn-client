# ghcr.io/coolcow/openvpn-client

A minimal Alpine-based Docker image for [OpenVPN](https://openvpn.net/community-resources/).

This image runs `openvpn` directly by default (root mode, suitable for `/dev/net/tun` usage). Optional `PUID`/`PGID` support is available via shared entrypoint scripts from `coolcow/entrypoints`.

---

## Usage

### Quick Start

```sh
docker run --rm ghcr.io/coolcow/openvpn-client --help
```

### Run with a Client Configuration

```sh
docker run --rm -it \
  --cap-add=NET_ADMIN \
  --device /dev/net/tun \
  -e OPENVPN_UID=$(id -u) \
  -e OPENVPN_GID=$(id -g) \
  -v /path/to/openvpn-home:/home/openvpn \
  -v /path/to/client.ovpn:/home/openvpn/client.ovpn:ro \
  ghcr.io/coolcow/openvpn-client \
  --config /home/openvpn/client.ovpn
```

### Optional Runtime Environment Variables

| Variable | Default | Target | Description |
| --- | --- | --- | --- |
| `OPENVPN_UID` | `1000` | `TARGET_UID` | User ID to run `openvpn` as. |
| `OPENVPN_GID` | `1000` | `TARGET_GID` | Group ID to run `openvpn` as. |
| `OPENVPN_REMAP_IDS` | `1` | `TARGET_REMAP_IDS` | Set `0` to disable remapping conflicting UID/GID entries. |
| `OPENVPN_USER` | `openvpn` | `TARGET_USER` | Runtime user name inside the container. |
| `OPENVPN_GROUP` | `openvpn` | `TARGET_GROUP` | Runtime group name inside the container. |
| `OPENVPN_HOME` | `/home/openvpn` | `TARGET_HOME` | Home directory used by `openvpn` and as default workdir. |
| `OPENVPN_SHELL` | `/bin/sh` | `TARGET_SHELL` | Login shell for the runtime user. |

`Target` shows the corresponding variable used by `coolcow/entrypoints`.

---

## Configuration

### Build-Time Arguments

Customize the image at build time with `docker build --build-arg <KEY>=<VALUE>`.

| Argument | Default | Description |
| --- | --- | --- |
| `ALPINE_VERSION` | `3.23.3` | Version of the Alpine base image. |
| `ENTRYPOINTS_VERSION` | `2.2.0` | Version of the `coolcow/entrypoints` image used for scripts. |

---

## Migration Notes

Runtime user/group environment variables were renamed to image-specific `OPENVPN_*` names.

- `PUID` → `OPENVPN_UID`
- `PGID` → `OPENVPN_GID`
- `ENTRYPOINT_USER` → `OPENVPN_USER`
- `ENTRYPOINT_GROUP` → `OPENVPN_GROUP`
- `ENTRYPOINT_HOME` → `OPENVPN_HOME`

Update your `docker run` / `docker-compose` environment configuration accordingly when upgrading from older tags.

---

## Local Testing

Run the built-in smoke tests locally.

1. `docker build -t ghcr.io/coolcow/openvpn-client:local-test-build -f build/Dockerfile build`
2. `docker build --build-arg APP_IMAGE=ghcr.io/coolcow/openvpn-client:local-test-build -f build/Dockerfile.test build`

---

## References

- [OpenVPN Community Resources](https://openvpn.net/community-resources/)
- [docker-entrypoints](https://github.com/coolcow/docker-entrypoints)

---

## License

GPL-3.0. See [LICENSE.txt](LICENSE.txt) for details.


