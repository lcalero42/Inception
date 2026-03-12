#!/bin/sh
set -e

DB_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")

chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Initializing MariaDB..."
    
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    
    mysqld --user=mysql --skip-networking &
    pid="$!"
    
    until mariadb-admin ping >/dev/null 2>&1; do sleep 1; done
    
    mariadb <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
CREATE DATABASE \`${MYSQL_DATABASE}\`;
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
    
    mariadb-admin shutdown
    wait "$pid"
fi

exec mysqld --user=mysql
