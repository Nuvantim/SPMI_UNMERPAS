#!/bin/sh
set -e

# Check if the application needs to be installed (using a flag file)
if [ ! -f /app/.installed ]; then
    echo "Running first-time installation..."
    touch /app/.installed
    chmod +x /app/install.sh
    sh /app/install.sh

    # Create group www-data
    adduser -D -u 1000 -G www-data www-data
   
    # Set Permission
    chown -R www-data:www-data /app
    chmod -R 775 /app/public /app/storage /app/bootstrap/cache
    apk del php83*
fi

# Create Path Frankenphp
export PATH=$PATH:/usr/bin

# Start Frankenphp
exec franken php-server --root /app/public --listen :80

# Worker mode if needed
#--worker /app/public/index.php,$(nproc)
