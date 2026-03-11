FROM debian:bookworm-slim

# Install PHP + extensions + unzip + curl for WP-CLI + redis-tools for healthcheck
RUN apt-get update && \
    apt-get install -y \
        php-fpm \
        php-mysql \
        php-cli \
        php-curl \
        php-xml \
        php-redis \
        unzip \
        curl \
        mariadb-client \
        redis-tools && \
    rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM to listen on 0.0.0.0:9000
RUN sed -i 's|listen = .*|listen = 0.0.0.0:9000|' /etc/php/*/fpm/pool.d/www.conf

# Download WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create WordPress directory
RUN mkdir -p /var/www/html

# Copy entrypoint
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/html
EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]