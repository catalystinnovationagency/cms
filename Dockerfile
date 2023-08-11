# Use PHP 7.3 with Apache
FROM php:7.3-apache

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
    libonig-dev

# Configure GD extension
RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ --with-freetype-dir=/usr/include/

# Install PHP extensions
RUN docker-php-ext-install mysqli pcre zip dom curl gettext gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy application source code to Apache document root
COPY . /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
