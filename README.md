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
  -v /path/to/client.ovpn:/home/client.ovpn:ro \
  ghcr.io/coolcow/openvpn-client \
  --config /home/client.ovpn
```

### Optional Runtime Environment Variables

| Variable | Default | Description |
| --- | --- | --- |
| `PUID` | _(unset)_ | Optional: if set (or if `PGID` is set), run via `su-exec` as that UID. |
| `PGID` | _(unset)_ | Optional: if set (or if `PUID` is set), run via `su-exec` as that GID. |
| `ENTRYPOINT_USER` | `openvpn` | Internal user name for optional su-exec mode. |
| `ENTRYPOINT_GROUP` | `openvpn` | Internal group name for optional su-exec mode. |
| `ENTRYPOINT_HOME` | `/home` | Working directory in the container. |

---

## Configuration

### Build-Time Arguments

Customize the image at build time with `docker build --build-arg <KEY>=<VALUE>`.

| Argument | Default | Description |
| --- | --- | --- |
| `ALPINE_VERSION` | `3.23.3` | Version of the Alpine base image. |
| `ENTRYPOINTS_VERSION` | `2.0.0` | Version of the `coolcow/entrypoints` image used for scripts. |

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


