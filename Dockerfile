FROM alpine:3.18

ENV ROOT=/var/www/html

# Setup document root
WORKDIR $ROOT

# Install packages and remove default server definition
RUN apk add --no-cache \
  curl \
  nginx \
  git \
  openssh \
  php81 \
  php81-ctype \
  php81-curl \
  php81-dom \
  php81-fpm \
  php81-gd \
  php81-intl \
  php81-mbstring \
  php81-session \
  php81-opcache \
  php81-openssl \
  php81-phar \
  php81-tokenizer \
  php81-fileinfo \
  php81-xml \
  php81-xmlwriter \
  php81-pdo \
  php81-pdo_pgsql \
  supervisor

# Configure nginx - http
COPY config/nginx.conf /etc/nginx/nginx.conf
# Configure nginx - default server
COPY config/conf.d /etc/nginx/conf.d/

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php81/php-fpm.d/www.conf
COPY config/php.ini /etc/php81/conf.d/custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Switch to use a non-root user from here on
USER nobody
