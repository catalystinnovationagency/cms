FROM php:8-apache
RUN a2enmod rewrite
COPY . /var/www/html
EXPOSE 80
CMD ["apache2-foreground"]
