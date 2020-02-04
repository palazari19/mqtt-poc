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

RUN docker-php-ext-enable opcache
RUN docker-php-ext-install calendar
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install tokenizer
RUN docker-php-ext-install json

RUN apt-get install -y \
        libonig-dev \
    && docker-php-ext-install iconv mbstring

RUN apt-get install -y \
        libcurl4-openssl-dev \
    && docker-php-ext-install curl

RUN apt-get install -y \
        libssl-dev \
    && docker-php-ext-install ftp phar

RUN apt-get install -y \
        libicu-dev \
    && docker-php-ext-install intl

RUN apt-get install -y \
        libmcrypt-dev \
    && docker-php-ext-install session

RUN apt-get install -y \
        libxml2-dev \
    && docker-php-ext-install simplexml xml xmlrpc

RUN apt-get install -y \
        libzip-dev \
        zlib1g-dev \
    && docker-php-ext-install zip

RUN apt-get install -y \
        libgmp-dev \
    && docker-php-ext-install gmp

RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

RUN apt-get install -y libmagickwand-dev
RUN pecl install imagick && docker-php-ext-enable imagick

RUN docker-php-ext-install sockets
RUN apt-get install -y git
#RUN git clone -b php7 https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis \
#    && docker-php-ext-install redis

RUN pecl install redis \
&& docker-php-ext-enable redis
COPY ./docker/apache.conf /etc/apache2
COPY ./docker/site-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf
#RUN apt-get install -y telnet iputils-ping git
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY . /var/www/html
RUN composer install
RUN a2enmod rewrite
