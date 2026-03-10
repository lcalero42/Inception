# srcs/requirements/bonus/static_website/Dockerfile
FROM debian:bookworm-slim

# Install Nginx
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# Create folder for static website
RUN mkdir -p /var/www/static_website

# Copy website files from tools folder
COPY tools/ /var/www/static_website/

# Set permissions
RUN chown -R www-data:www-data /var/www/static_website

# Nginx configuration for static website
RUN echo 'server {\n\
    listen 80;\n\
    server_name localhost;\n\
    root /var/www/static_website;\n\
    index index.html;\n\
    location / {\n\
        try_files $uri $uri/ =404;\n\
    }\n\
}' > /etc/nginx/sites-available/static_website.conf

# Enable site
RUN ln -s /etc/nginx/sites-available/static_website.conf /etc/nginx/sites-enabled/

# Remove default site to avoid conflicts
RUN rm /etc/nginx/sites-enabled/default

# Expose HTTP port
EXPOSE 80

# Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
