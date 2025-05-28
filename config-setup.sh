#!/usr/bin/with-contenv bash
# This script runs during s6 initialization phase

echo "=== Heimdall HA Addon Setup Debug ==="

# Debug: Show what directories exist
echo "Current /data contents:"
ls -la /data/ || echo "/data not found"

echo "Current /config contents before setup:"
ls -la /config/ || echo "/config not found"

# Check if we have persistent storage mapped
if [ -d "/data" ]; then
    echo "✓ Persistent storage available at /data"
    
    # Create heimdall config directory in persistent storage
    mkdir -p /data/heimdall
    echo "✓ Created /data/heimdall"
    
    # Set ownership
    chown -R abc:abc /data/heimdall
    echo "✓ Set ownership on /data/heimdall"
    
    # Check if config already exists in persistent storage
    if [ -f "/data/heimdall/.env" ]; then
        echo "✓ Found existing Heimdall config in persistent storage"
    else
        echo "! No existing config found in persistent storage"
    fi
    
else
    echo "✗ No persistent storage found - data will not persist!"
fi

# Debug: Check environment variables that might affect Heimdall
echo "Environment check:"
echo "PWD: $PWD"
echo "USER: $USER"
echo "HOME: $HOME"

echo "=== End Debug Info ==="
