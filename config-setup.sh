#!/usr/bin/with-contenv bash
# This script runs during s6 initialization phase

# Source bashio if available
if command -v bashio &> /dev/null; then
    # Parse Home Assistant addon configuration here
    echo "Setting up Heimdall with Home Assistant configuration..."

    echo "Setting up Heimdall for Home Assistant addon..."

    # Force Heimdall to bind to all interfaces (not just localhost)
    # LinuxServer.io images sometimes default to localhost only
    export HEIMDALL_HOST=0.0.0.0
    
    # Ensure proper permissions for web directory
    chown -R abc:abc /config
    
    # Example: Read configuration options
    # CUSTOM_SETTING=$(bashio::config 'custom_setting')
    # export CUSTOM_SETTING
    
    # You can set environment variables here that Heimdall will use
    # Or modify configuration files before Heimdall starts
    
    echo "Configuration setup complete"
else
    echo "Bashio not available, using default configuration"
fi
