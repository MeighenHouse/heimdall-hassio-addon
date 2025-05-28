# Use LinuxServer.io Heimdall as base - they do all the heavy lifting
FROM lscr.io/linuxserver/heimdall:latest

# Add bashio for Home Assistant addon configuration support
RUN apk add --no-cache curl jq

# Install bashio for configuration parsing
RUN curl -J -L -s -o /tmp/bashio.tar.gz \
    "https://github.com/hassio-addons/bashio/archive/v0.16.2.tar.gz" \
    && tar -xzf /tmp/bashio.tar.gz -C /tmp \
    && mv /tmp/bashio-0.16.2 /tmp/bashio \
    && cp -r /tmp/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    && rm -rf /tmp/bashio*

# Copy our simple startup script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Use our script as entrypoint but preserve LinuxServer.io's init system
ENTRYPOINT ["/run.sh"]
