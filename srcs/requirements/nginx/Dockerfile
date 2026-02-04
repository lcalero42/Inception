FROM alpine:3.18

# 1. Install nginx (correct package manager)
RUN apk update && apk add --no-cache nginx openssl

# 2. Create required directories
RUN mkdir -p /run/nginx /etc/nginx/ssl /var/www/html

# 3. Copy nginx configuration (TLS enforced there)
COPY conf/nginx.conf /etc/nginx/nginx.conf

# 4. Copy TLS certificates
COPY ssl /etc/nginx/ssl

# 5. Expose HTTPS only
EXPOSE 443

# 6. Run nginx in foreground (PID 1)
CMD ["nginx", "-g", "daemon off;"]
