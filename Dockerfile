FROM php:fpm-alpine

RUN echo -e "http://mirrors.ustc.edu.cn/alpine/v3.6/main" > /etc/apk/repositories && \
    echo -e "http://mirrors.ustc.edu.cn/alpine/v3.6/community" >> /etc/apk/repositories
RUN apk update \
	&& apk add --no-cache openssl-dev libpng libpng-dev pcre-dev ${PHPIZE_DEPS}

RUN docker-php-ext-install opcache \
	&& docker-php-ext-install pdo \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install gd \
	&& docker-php-ext-install sockets

#RUN pecl install redis && pecl install swoole && docker-php-ext-enable redis swoole

RUN cd /home && wget http://pecl.php.net/get/redis-4.0.0.tgz && \
	tar -zxvf redis-4.0.0.tgz && cd redis-4.0.0 && \
    phpize && \
    ./configure && \
    make && make install && \
	docker-php-ext-enable redis

RUN cd /home && wget http://pecl.php.net/get/swoole-2.1.2.tgz && \
	tar -zxvf swoole-2.1.2.tgz && cd swoole-2.1.2 && \
    phpize && \
    ./configure && \
    make && make install && \
	docker-php-ext-enable swoole



## Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

