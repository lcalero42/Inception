#!/bin/sh
set -e

# Read secrets
DB_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")

# Ensure permissions (volume-safe)
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# Initialize database only once
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."

    mariadb-install-db \
        --user=mysql \
        --datadir=/var/lib/mysql

    # Start MariaDB temporarily
    mysqld --user=mysql --skip-networking &
    pid="$!"

    # Wait for server
    until mariadb-admin ping >/dev/null 2>&1; do
        sleep 1
    done

    # Create DB and users
    mariadb <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    # Stop temp server
    mariadb-admin shutdown
    wait "$pid"
fi

# Start MariaDB normally
exec mysqld --user=mysql
