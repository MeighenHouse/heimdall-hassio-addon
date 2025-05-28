#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Heimdall
# Runs the Heimdall application
# ==============================================================================

# Wait for MySQL to become available (if used)
bashio::log.info "Starting Heimdall..."

# Get configuration options
HTTP_PORT=$(bashio::config 'http_port')
HTTPS_PORT=$(bashio::config 'https_port')
SSL=$(bashio::config 'ssl')
CERTFILE=$(bashio::config 'certfile')
KEYFILE=$(bashio::config 'keyfile')

# Create nginx configuration
bashio::log.info "Configuring nginx..."

# Generate nginx config
{
    echo "user nginx;"
    echo "worker_processes auto;"
    echo "error_log /var/log/nginx/error.log warn;"
    echo "pid /var/run/nginx.pid;"
    echo ""
    echo "events {"
    echo "    worker_connections 1024;"
    echo "}"
    echo ""
    echo "http {"
    echo "    include /etc/nginx/mime.types;"
    echo "    default_type application/octet-stream;"
    echo "    sendfile on;"
    echo "    keepalive_timeout 65;"
    echo "    client_max_body_size 100M;"
    echo ""
    echo "    server {"
    
    if bashio::var.true "${SSL}"; then
        echo "        listen ${HTTPS_PORT} ssl http2;"
        echo "        ssl_certificate /ssl/${CERTFILE};"
        echo "        ssl_certificate_key /ssl/${KEYFILE};"
        echo "        ssl_protocols TLSv1.2 TLSv1.3;"
        echo "        ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384;"
        echo "        ssl_prefer_server_ciphers off;"
    else
        echo "        listen ${HTTP_PORT};"
    fi
    
    echo "        server_name _;"
    echo "        root /var/www/heimdall/public;"
    echo "        index index.php index.html;"
    echo ""
    echo "        location / {"
    echo "            try_files \$uri \$uri/ /index.php?\$query_string;"
    echo "        }"
    echo ""
    echo "        location ~ \.php$ {"
    echo "            fastcgi_pass unix:/var/run/php-fpm82.sock;"
    echo "            fastcgi_index index.php;"
    echo "            fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;"
    echo "            include fastcgi_params;"
    echo "        }"
    echo ""
    echo "        location ~ /\.ht {"
    echo "            deny all;"
    echo "        }"
    echo "    }"
    echo "}"
} > /etc/nginx/nginx.conf

# Set up Heimdall environment
export APP_ENV=production
export APP_DEBUG=false
export APP_KEY=$(openssl rand -base64 32)
export APP_URL="http://localhost:${HTTP_PORT}"
export DB_CONNECTION=sqlite
export DB_DATABASE=/data/app.sqlite

# Create database directory if it doesn't exist
mkdir -p /data

# Set up Heimdall storage links
if [ ! -L "/var/www/heimdall/storage" ]; then
    rm -rf /var/www/heimdall/storage
    ln -sf /data/storage /var/www/heimdall/storage
fi

if [ ! -L "/var/www/heimdall/database/app.sqlite" ]; then
    mkdir -p /var/www/heimdall/database
    rm -f /var/www/heimdall/database/app.sqlite
    ln -sf /data/app.sqlite /var/www/heimdall/database/app.sqlite
fi

# Create storage directories
mkdir -p /data/storage/app/public
mkdir -p /data/storage/framework/cache
mkdir -p /data/storage/framework/sessions
mkdir -p /data/storage/framework/views
mkdir -p /data/storage/logs

# Set permissions
chown -R nginx:nginx /var/www/heimdall
chown -R nginx:nginx /data
chmod -R 755 /data

# Start PHP-FPM
bashio::log.info "Starting PHP-FPM..."
php-fpm82 --nodaemonize --fpm-config /etc/php82/php-fpm.conf &

# Wait a moment for PHP-FPM to start
sleep 2

# Start nginx
bashio::log.info "Starting nginx..."
if bashio::var.true "${SSL}"; then
    bashio::log.info "SSL is enabled. Heimdall will be available on port ${HTTPS_PORT}"
else
    bashio::log.info "Heimdall will be available on port ${HTTP_PORT}"
fi

nginx -g "daemon off;"
