FROM php:7.1.15-fpm-alpine3.4

RUN echo http://mirrors.aliyun.com/alpine/v3.4/main > /etc/apk/repositories && \
    echo http://mirrors.aliyun.com/alpine/v3.4/community >> /etc/apk/repositories && \
    apk update && apk upgrade

RUN docker-php-ext-install opcache 
RUN docker-php-ext-install pdo_mysql 
RUN apk add --no-cache libpng libpng-dev
RUN docker-php-ext-install gd
RUN docker-php-ext-install sockets 


## Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

