FROM alpine:latest

# Install dependencies & PHP extensions
RUN apk update && apk upgrade && apk add --no-cache curl git unzip php83 php83-pdo php83-iconv php83-pdo_pgsql php83-pdo_mysql php83-mysqlnd php83-openssl php83-mbstring php83-tokenizer php83-fileinfo php83-ctype php83-curl php83-phar php83-session php83-dom php83-xml php83-xmlwriter

# Symbolic link php
RUN ln -s /usr/bin/php83 /usr/bin/php

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer
    
# Set working directory
RUN mkdir -p /app
WORKDIR /app

# Copy application source
COPY . .

# Copy entrypoint script
RUN mv deploy/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Install Frankenphp
RUN curl -L -o /usr/bin/franken https://github.com/php/frankenphp/releases/download/v1.2.4/frankenphp-linux-x86_64-mimalloc && \
    chmod +x /usr/bin/franken

CMD ["/entrypoint.sh"]
