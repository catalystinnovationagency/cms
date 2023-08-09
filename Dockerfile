# Use an official PHP image with Apache
FROM php:8-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    zip \
    curl \
    git \
    libzip-dev \
    gettext \
    libcurl4-openssl-dev \
    libonig-dev

# Install PHP extensions
RUN docker-php-ext-install mysqli mysqlnd xml libxml pcre zip dom curl gettext gd

# If imagick is required, you can also install it
# RUN apt-get install -y libmagickwand-dev && pecl install imagick && docker-php-ext-enable imagick

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy application source code to Apache document root
COPY . /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
