FROM php:8.1-fpm-alpine

RUN apk update && apk add autoconf g++ make icu-dev libpq postgresql-dev libzip-dev zip libpng-dev \
    && docker-php-ext-install pdo_mysql intl zip opcache pcntl \
    && docker-php-ext-configure zip \
    && docker-php-ext-configure gd \
        --enable-gd-native-ttf \
        --with-freetype-dir=/usr/include/freetype2 \
        --with-png-dir=/usr/include \
        --with-jpeg-dir=/usr/include \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-enable zip opcache pcntl gd \

RUN apk add --no-cache tzdata
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY php.ini /usr/local/etc/php/

WORKDIR /app
