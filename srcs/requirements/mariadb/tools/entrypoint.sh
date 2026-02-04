#!/bin/sh
set -e

# Create required directories
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql

# Initialize database if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

# Exec MariaDB as mysql user (THIS IS THE KEY LINE)
exec mysqld --user=mysql
