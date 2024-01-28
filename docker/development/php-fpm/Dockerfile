FROM php:7.4-fpm-alpine

# Change the mirror to a different one
RUN sed -i -e 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories

RUN apk update && apk add autoconf g++ make icu-dev libpq postgresql-dev libzip-dev zip libpng-dev freetype-dev libjpeg-turbo-dev \
    && docker-php-ext-install pdo_mysql intl zip opcache pcntl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install gd \
    && apk del autoconf g++ make \
    && rm -rf /var/cache/apk/*

RUN apk add --no-cache tzdata
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY php.ini /usr/local/etc/php/

WORKDIR /app
