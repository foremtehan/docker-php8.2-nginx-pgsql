FROM alpine:3.18

# Install packages and remove default server definition
RUN apk add --no-cache \
  curl \
  nginx \
  git \
  php82 \
  php82-ctype \
  php82-curl \
  php82-dom \
  php82-fpm \
  php82-gd \
  php82-intl \
  php82-mbstring \
  php82-session \
  php82-opcache \
  php82-openssl \
  php82-phar \
  php82-tokenizer \
  php82-fileinfo \
  php82-xml \
  php82-xmlwriter \
  php82-pdo \
  php82-pdo_pgsql \
  supervisor

# Create symlink so programs depending on `php` still function
RUN ln -s /usr/bin/php82 /usr/bin/php

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /var/www/html /run /var/lib/nginx /var/log/nginx /var/log/php82

# Configure nginx - http
COPY config/nginx.conf /etc/nginx/nginx.conf
# Configure nginx - default server
COPY config/conf.d /etc/nginx/conf.d/

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php82/php-fpm.d/www.conf
COPY config/php.ini /etc/php82/conf.d/custom.ini
