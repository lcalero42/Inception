#!/bin/sh
set -e

# Increase PHP memory for WP-CLI
export PHP_MEMORY_LIMIT=512M
export WP_CLI_PHP_ARGS="-d memory_limit=512M"

DB_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")

# Load WordPress credentials
. "$WP_CREDENTIALS_PATH"

# Wait for MariaDB
until mariadb -h mariadb -u"$MYSQL_USER" -p"$DB_PASSWORD" "$MYSQL_DATABASE" >/dev/null 2>&1; do
    sleep 1
done

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

# Start PHP-FPM
exec php-fpm81 -F
