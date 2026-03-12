#!/bin/sh
set -e

# Increase PHP memory for WP-CLI
export PHP_MEMORY_LIMIT=512M
export WP_CLI_PHP_ARGS="-d memory_limit=512M"

DB_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")

# Load WordPress credentials
. "$WP_CREDENTIALS_PATH"

# Wait for Redis to be ready
until redis-cli -h redis ping 2>/dev/null | grep -q "PONG"; do
    echo "Waiting for Redis..."
    sleep 1
done

# Install WordPress if it does not exist yet
if [ ! -f wp-config.php ]; then
    wp core download --allow-root
    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="mariadb" \
        --allow-root
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root
    wp user create \
        "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --allow-root
fi

# Ensure Redis configuration exists in wp-config.php
if ! wp config has WP_CACHE --allow-root; then
    wp config set WP_CACHE true --raw --allow-root
fi
if ! wp config has WP_REDIS_HOST --allow-root; then
    wp config set WP_REDIS_HOST redis --allow-root
fi
if ! wp config has WP_REDIS_PORT --allow-root; then
    wp config set WP_REDIS_PORT 6379 --raw --allow-root
fi

# Install Redis plugin if missing
if ! wp plugin is-installed redis-cache --allow-root; then
    wp plugin install redis-cache --activate --allow-root
fi

# Activate plugin if installed but not active
if ! wp plugin is-active redis-cache --allow-root; then
    wp plugin activate redis-cache --allow-root
fi

# Enable Redis object cache drop-in if not connected
if ! wp redis status --allow-root 2>&1 | grep -q "Status: Connected"; then
    wp redis enable --allow-root
fi

# Start PHP-FPM
exec php-fpm8.2 -F