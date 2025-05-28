ARG BUILD_FROM=ghcr.io/hassio-addons/base:15.0.7
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base system
ARG BUILD_ARCH=amd64

# Install packages
RUN \
    apk add --no-cache \
        nginx=1.24.0-r6 \
        php82=8.2.13-r0 \
        php82-fpm=8.2.13-r0 \
        php82-curl=8.2.13-r0 \
        php82-dom=8.2.13-r0 \
        php82-gd=8.2.13-r0 \
        php82-json=8.2.13-r0 \
        php82-mbstring=8.2.13-r0 \
        php82-mysqli=8.2.13-r0 \
        php82-opcache=8.2.13-r0 \
        php82-openssl=8.2.13-r0 \
        php82-pdo=8.2.13-r0 \
        php82-pdo_mysql=8.2.13-r0 \
        php82-pdo_sqlite=8.2.13-r0 \
        php82-session=8.2.13-r0 \
        php82-simplexml=8.2.13-r0 \
        php82-sqlite3=8.2.13-r0 \
        php82-xml=8.2.13-r0 \
        php82-xmlreader=8.2.13-r0 \
        php82-zip=8.2.13-r0 \
        sqlite=3.43.2-r0

# Set Heimdall version
ENV HEIMDALL_VERSION=2.6.1

# Download and install Heimdall
RUN \
    curl -J -L -o /tmp/heimdall.tar.gz \
        "https://github.com/linuxserver/Heimdall/archive/v${HEIMDALL_VERSION}.tar.gz" \
    && tar xzf /tmp/heimdall.tar.gz -C /tmp \
    && mkdir -p /var/www/heimdall \
    && cp -r /tmp/Heimdall-${HEIMDALL_VERSION}/* /var/www/heimdall/ \
    && rm -rf /tmp/heimdall.tar.gz /tmp/Heimdall-${HEIMDALL_VERSION}

# Set up directories and permissions
RUN \
    mkdir -p /data \
    && mkdir -p /var/www/heimdall/storage \
    && mkdir -p /var/www/heimdall/database \
    && chown -R nginx: /var/www/heimdall \
    && chown -R nginx: /data

# Configure PHP-FPM
RUN \
    sed -i 's/user = www-data/user = nginx/' /etc/php82/php-fpm.d/www.conf \
    && sed -i 's/group = www-data/group = nginx/' /etc/php82/php-fpm.d/www.conf \
    && sed -i 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm82.sock/' /etc/php82/php-fpm.d/www.conf \
    && sed -i 's/;listen.owner = www-data/listen.owner = nginx/' /etc/php82/php-fpm.d/www.conf \
    && sed -i 's/;listen.group = www-data/listen.group = nginx/' /etc/php82/php-fpm.d/www.conf \
    && sed -i 's/;listen.mode = 0660/listen.mode = 0660/' /etc/php82/php-fpm.d/www.conf

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Your Name <your.email@example.com>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Your Name <your.email@example.com>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
