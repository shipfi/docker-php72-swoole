FROM php:7.2
COPY ./sources.list /etc/apt

# Install modules 
RUN apt-get update && \
        apt-get install -y wget curl git libmcrypt-dev \
                libjpeg62-turbo-dev \
                libmcrypt-dev \
                openssl libssh-dev \
                libnghttp2-dev \
                libpng-dev \
                libhiredis-dev \
                libghc-bzlib-dev

# install php pdo_mysql opcache bz2, bcmath, zip....
RUN docker-php-ext-install bz2 bcmath zip iconv sockets gd pdo_mysql mysqli iconv mbstring json opcache 
# RUN docker-php-ext-configure gd 
# RUN docker-php-ext-install gd mcrypt
# RUN docker-php-ext-install pdo_mysql mysqli iconv mbstring json mcrypt opcache 


# install dom xml
#RUN apt-get install libxml2 && docker-php-ext-install dom simplexml xmlreader
# install php curl
#RUN apt-get install libcurl && docker-php-ext-install curl

# install mcrypt
RUN pecl install mcrypt-1.0.1
RUN docker-php-ext-enable mcrypt

# install swoole
#RUN pecl install swoole
RUN cd /root && pecl download swoole-4.1.2 && \
    tar -zxvf swoole-4* && cd swoole-4.1.2 && \
    phpize && \
    ./configure --enable-openssl  --enable-http2  --enable-async-redis --enable-sockets && \
    make && make install 
RUN docker-php-ext-enable swoole

#install redis
# 
#ENV PHPREDIS_VERSION php7
#RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
#    && tar xfz /tmp/redis.tar.gz \
#    && rm -r /tmp/redis.tar.gz \
#    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
#    && docker-php-ext-install redis
RUN pecl install  igbinary && docker-php-ext-enable igbinary
RUN pecl install  redis && docker-php-ext-enable redis


# log to /var/www/log
# RUN mkdir -p /var/www/log
# RUN echo "error_log = /var/www/log/php_error.log" > /usr/local/etc/php/conf.d/log.ini
RUN echo "log_errors = On" >> /usr/local/etc/php/conf.d/log.ini \
    && echo "error_log=/dev/stderr" >> /usr/local/etc/php/conf.d/log.ini

# add user additional conf for apache & php
# add to CMD mkdir -p /var/www/conf/php && mkdir -p /var/www/conf/apache2 &&
# RUN echo "" >> /usr/local/php/conf.d/additional.ini
# RUN echo "" >> /etc/apache2/conf-enabled/additional.conf

# set system timezone & php timezone
# @TODO

RUN wget https://install.phpcomposer.com/composer.phar | php 
RUN mv composer.phar /usr/local/bin/composer
RUN chmod a+x /usr/local/bin/composer && composer config -g repo.packagist composer https://packagist.phpcomposer.com

# clean files
RUN rm -rf /tmp && rm -rf /root/swoole*