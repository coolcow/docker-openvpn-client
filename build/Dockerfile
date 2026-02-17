# Global build arguments
ARG ENTRYPOINTS_VERSION=2.2.0
ARG ALPINE_VERSION=3.23.3

# Stage to fetch scripts from the versioned entrypoints asset image
FROM ghcr.io/coolcow/entrypoints:${ENTRYPOINTS_VERSION} AS entrypoints

# Main build stage
FROM alpine:${ALPINE_VERSION}

# Runtime environment variables needed by the entrypoint scripts.
ENV OPENVPN_UID=1000 \
      OPENVPN_GID=1000 \
      OPENVPN_REMAP_IDS=1 \
      OPENVPN_USER=openvpn \
      OPENVPN_GROUP=openvpn \
      OPENVPN_HOME=/home/openvpn \
      OPENVPN_SHELL=/bin/sh

# Install OpenVPN and required dependencies for optional user switching
RUN apk --no-cache --update add \
      openvpn \
      shadow \
      su-exec

# Copy required scripts from the entrypoints asset image
COPY --from=entrypoints /assets/ensure_user_group_home.sh /usr/local/bin/
COPY --from=entrypoints /assets/entrypoint_su-exec.sh /usr/local/bin/

# Copy local wrapper entrypoint
COPY entrypoint.sh /usr/local/bin/

# Make scripts executable
RUN chmod +x /usr/local/bin/*.sh

WORKDIR $OPENVPN_HOME

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["--help"]

ARG LABEL_VERSION="latest"
ARG LABEL_BUILD_DATE
ARG LABEL_VCS_REF
ARG LABEL_LICENSE="GPL-3.0"
ARG LABEL_IMAGE_NAME="ghcr.io/coolcow/openvpn-client"
ARG LABEL_DESCRIPTION="Minimal Alpine-based OpenVPN client image with optional su-exec entrypoint mode."
ARG LABEL_URL="https://ghcr.io/coolcow/openvpn-client"
ARG LABEL_VCS_URL="https://github.com/coolcow/docker-openvpn-client"
ARG LABEL_MAINTAINER="Jean-Michel Ruiz (coolcow) <mail@coolcow.org>"

# OCI / OpenContainer image labels
LABEL org.opencontainers.image.title=$LABEL_IMAGE_NAME \
      org.opencontainers.image.description=$LABEL_DESCRIPTION \
      org.opencontainers.image.version=$LABEL_VERSION \
      org.opencontainers.image.created=$LABEL_BUILD_DATE \
      org.opencontainers.image.revision=$LABEL_VCS_REF \
      org.opencontainers.image.authors=$LABEL_MAINTAINER \
      org.opencontainers.image.licenses=$LABEL_LICENSE \
      org.opencontainers.image.source=$LABEL_VCS_URL \
      org.opencontainers.image.url=$LABEL_URL

VOLUME $OPENVPN_HOME