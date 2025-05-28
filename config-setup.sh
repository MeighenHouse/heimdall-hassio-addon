#!/usr/bin/with-contenv bash

echo "Setting up Heimdall for Home Assistant addon..."

# The LinuxServer.io base image is designed to use /config for its data.
# It will create necessary subdirectories like /config/www, /config/nginx, etc.
# We just need to ensure the 'abc' user (common in LS.io images) can write to it.
# The base image's init scripts (running before this one) usually handle PUID/PGID
# which should set ownership correctly. However, an explicit chown can be a safeguard
# or if PUID/PGID aren't being effectively used/set in the HA environment for this user.
# chown -R abc:abc /config

# (Optional) Set Heimdall to bind to all interfaces if not default in base image
# Most LinuxServer.io web services bind to 0.0.0.0 by default in their nginx/webserver configs.
# This environment variable might be used by Heimdall or a script in the base image.
# Check LS.io Heimdall docs if this is necessary or handled differently.
# export HEIMDALL_HOST=0.0.0.0

echo "Ensuring Heimdall uses /config for persistent data."

# Source bashio for parsing Home Assistant addon configuration options
if command -v bashio &> /dev/null && [ -f /data/options.json ]; then
    bashio::log.info "Bashio is available. Parsing addon options..."

    # Example: If you wanted to allow users to set PHP's max upload size via addon options
    # if bashio::config.has_value 'php_upload_max_filesize'; then
    #     UPLOAD_MAX_SIZE=$(bashio::config 'php_upload_max_filesize')
    #     bashio::log.info "Setting PHP upload_max_filesize to ${UPLOAD_MAX_SIZE}..."
    #     # You would then need to find the relevant php.ini (e.g., /config/php/php-local.ini)
    #     # and update the value using sed or similar.
    #     # This is just an example; actual implementation depends on the base image structure.
    # fi
else
    bashio::log.info "Bashio not available or no options.json found. Using default Heimdall behavior."
fi

echo "Heimdall configuration setup complete. Data will persist in the Home Assistant managed /config directory."
