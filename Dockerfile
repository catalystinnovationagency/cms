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

# Configure GD extension with JPEG and FreeType support
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install PHP extensions
RUN docker-php-ext-install mysqli xml libxml pcre zip dom curl gettext gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy application source code to Apache document root
COPY . /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
