FROM php:fpm-alpine

RUN echo -e "http://mirrors.ustc.edu.cn/alpine/latest-stable/main" > /etc/apk/repositories && \
    echo -e "http://mirrors.ustc.edu.cn/alpine/latest-stable/community" >> /etc/apk/repositories && \
    apk update && apk upgrade

RUN apk add --no-cache libpng libpng-dev

RUN docker-php-ext-install opcache \
	&& docker-php-ext-install pdo \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install gd \
	&& docker-php-ext-install sockets

RUN pecl install redis && docker-php-ext-enable redis

RUN cd /root && pecl download swoole && \
    tar -zxvf swoole-1* && cd swoole-1* && \
    phpize && \
    ./configure --enable-openssl  --enable-http2  --enable-async-redis && \
    make && make install 
RUN docker-php-ext-enable swoole



## Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

