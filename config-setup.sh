#!/usr/bin/with-contenv bash
# This script runs during s6 initialization phase

echo "Setting up Heimdall for Home Assistant addon..."

# Create the persistent config directory if it doesn't exist
mkdir -p /data/heimdall-config

# Check if this is first run or if we need to migrate existing config
if [ ! -d "/data/heimdall-config/www" ] && [ -d "/config/www" ]; then
    echo "Migrating existing config to persistent storage..."
    cp -r /config/* /data/heimdall-config/ 2>/dev/null || true
fi

# Remove the original config directory and create a symlink to persistent storage
rm -rf /config
ln -sf /data/heimdall-config /config

# Ensure proper ownership for the abc user (used by LinuxServer.io images)
chown -R abc:abc /data/heimdall-config

# Force Heimdall to bind to all interfaces (not just localhost)
export HEIMDALL_HOST=0.0.0.0

# Source bashio if available for future configuration options
if command -v bashio &> /dev/null; then
    echo "Bashio available for configuration parsing"
    # Future: Parse Home Assistant addon configuration here
    # CUSTOM_SETTING=$(bashio::config 'custom_setting')
else
    echo "Using default configuration"
fi

echo "Configuration setup complete - data will persist in /data/heimdall-config"
