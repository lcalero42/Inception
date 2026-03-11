FROM debian:bookworm-slim

# Install Nginx and SSL support
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# Create necessary directories
RUN mkdir -p /var/www/html /var/www/static /etc/nginx/ssl && \
    chown -R www-data:www-data /var/www/html /var/www/static

# Copy configuration and SSL certificates
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY ssl /etc/nginx/ssl

RUN chown -R www-data:www-data /var/www/html

# Expose HTTPS port
EXPOSE 443

# Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
