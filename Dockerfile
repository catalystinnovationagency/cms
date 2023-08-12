# Use PHP 7.4 with Nginx
FROM php:7.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libxml2-dev \
    zip \
    curl \
    git \
    libzip-dev \
    gettext \
    libcurl4-openssl-dev \
    libonig-dev \
    nginx \
    mysql-client

# Install GD extension
RUN docker-php-ext-configure gd --with-jpeg --with-freetype && \
    docker-php-ext-install gd

# Install other PHP extensions
RUN docker-php-ext-install mysqli mysqlnd xml libxml pcre zip dom curl gettext

# Copy Nginx configuration file
COPY nginx.conf /etc/nginx/sites-available/vvveb
RUN ln -s /etc/nginx/sites-available/vvveb /etc/nginx/sites-enabled/vvveb

# Copy application source code
COPY . /var/www/html

# Start Nginx and PHP-FPM
CMD service nginx start && php-fpm
