FROM php:7.4.2-apache-buster

MAINTAINER Pedro Lazari
USER root
RUN apt update
RUN apt-get install -y libmosquitto-dev
RUN pecl install Mosquitto-alpha

#RUN chown -R /var/www/html
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \

        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev \
        libonig-dev \
        graphviz \

    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-source delete
COPY ./docker/apache.conf /etc/apache2
COPY ./docker/site-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf
RUN apt-get install -y telnet iputils-ping git
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN a2enmod rewrite
