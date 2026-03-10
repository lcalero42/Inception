FROM debian:bookworm-slim

# Download dependecies
RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql curl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html

# Download Adminer
RUN curl -L https://www.adminer.org/latest.php -o /var/www/html/index.php

WORKDIR /var/www/html

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080"]
