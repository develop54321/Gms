FROM php:8.1-cli-alpine

RUN apk update && apk add autoconf g++ make icu-dev libpq postgresql-dev libzip-dev zip libpng-dev \
    && docker-php-ext-install pdo_mysql gd bz2 \
    && docker-php-ext-install pdo_pgsql intl zip opcache pcntl \
    && docker-php-ext-enable zip opcache intl pcntl \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer --quiet

ENV COMPOSER_ALLOW_SUPERUSER 1

RUN apk add --no-cache tzdata
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY php.ini /usr/local/etc/php/

WORKDIR /app
