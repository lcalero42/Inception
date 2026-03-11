FROM debian:bookworm-slim

# Install Nginx and SSL support
RUN apt-get update && \
    apt-get install -y nginx  openssl && \
    rm -rf /var/lib/apt/lists/*

# Create necessary directories
RUN mkdir -p /var/www/html /var/www/static /etc/nginx/ssl && \
    chown -R www-data:www-data /var/www/html /var/www/static

# Generate self-signed SSL certificate at build time
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/key.pem \
    -out /etc/nginx/ssl/cert.pem \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=inception/CN=lcalero.42.fr"

# Copy configuration and SSL certificates
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN chown -R www-data:www-data /var/www/html

# Expose HTTPS port
EXPOSE 443

# Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
