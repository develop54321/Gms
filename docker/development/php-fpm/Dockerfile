FROM php:8.1-fpm-alpine

RUN apk update && apk add autoconf g++ make icu-dev libpq postgresql-dev libzip-dev zip libpng-dev \
    && docker-php-ext-install pdo_mysql intl zip opcache pcntl \
    && docker-php-ext-enable zip opcache pcntl \
    && docker-php-ext-configure zip \
    && docker-php-ext-install gd \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

RUN apk add --no-cache tzdata
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY php.ini /usr/local/etc/php/

WORKDIR /app
