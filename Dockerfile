FROM php:7.3-apache

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Run apt update and install some dependancies needed for docker-php-ext
RUN apt update && apt install -y apt-utils unzip zip libpng-dev libmcrypt-dev git \
  curl libicu-dev libxml2-dev libssl-dev libcurl4 libcurl3-dev libsqlite3-dev libsqlite3-0

# Install PHP extensions
RUN docker-php-ext-install mysqli bcmath gd intl xml curl pdo_mysql pdo_sqlite hash session opcache
#RUN docker-php-ext-install zip

# Update web root to public
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# Update web root to public
# See: https://hub.docker.com/_/php#changing-documentroot-or-other-apache-configuration

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf


# Enable mod_rewrite
RUN a2enmod rewrite

USER root
# RUN chmod 755 /usr/local/bin/composer - give this if needed

CMD /usr/sbin/apache2ctl -D FOREGROUND


EXPOSE 8080