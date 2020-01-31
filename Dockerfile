FROM php:7.4.2-apache-buster

MAINTAINER Pedro Lazari
USER root
RUN apt update
RUN apt-get install -y libmosquitto-dev
RUN pecl install Mosquitto-alpha

#RUN chown -R /var/www/html

COPY ./docker/apache.conf /etc/apache2
COPY ./docker/site-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf
RUN apt-get install -y telnet iputils-ping git
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN a2enmod rewrite
