FROM ghcr.io/stacktonic/alpine:v0.0.2

ARG PHP_VERSION=8
ENV PHP_VERSION $PHP_VERSION

RUN  apk add --no-cache supervisor && \
     rm -rf /tmp/*

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv \
    && apk add -U --no-cache \
    # Packages
    tini \
    php${PHP_VERSION} \
    php${PHP_VERSION}-common \
    php${PHP_VERSION}-dev \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-gmp \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-mysqlnd \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-pdo \
    php${PHP_VERSION}-pdo_mysql \
    php${PHP_VERSION}-pdo_sqlite \
    php${PHP_VERSION}-pdo_pgsql \
    php${PHP_VERSION}-pear \
    php${PHP_VERSION}-pecl-apcu \
    php${PHP_VERSION}-pecl-redis \
    php${PHP_VERSION}-pgsql \
    php${PHP_VERSION}-posix \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-sodium \
    php${PHP_VERSION}-xmlreader \
    php${PHP_VERSION}-bcmath \
    php${PHP_VERSION}-bz2 \
    php${PHP_VERSION}-ctype \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-ftp \
    php${PHP_VERSION}-iconv \
    php${PHP_VERSION}-ldap \
    php${PHP_VERSION}-pcntl \
    php${PHP_VERSION}-phar \
    php${PHP_VERSION}-session \
    php${PHP_VERSION}-shmop \
    php${PHP_VERSION}-sockets \
    php${PHP_VERSION}-sodium \
    php${PHP_VERSION}-sqlite3 \
    php${PHP_VERSION}-sysvmsg \
    php${PHP_VERSION}-sysvsem \
    php${PHP_VERSION}-sysvshm \
    php${PHP_VERSION}-tokenizer \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-xsl \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-zlib \
    # Iconv Fix
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted php${PHP_VERSION}-pecl-apcu \
    && ln -s /usr/bin/php${PHP_VERSION} /usr/bin/php
    
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php %% \
    php -r "unlink('composer-setup.php');"

CMD []

COPY root/ /

ENTRYPOINT ["/init"]