FROM wordpress:latest

# install the PHP extensions we need
RUN set -x \
        && apt-get update \
        && apt-get install -y \
                libfreetype6-dev \
                libjpeg62-turbo-dev \
                libpng-dev \
                libonig-dev \
                libpq-dev \
                libicu-dev \
                libxml2-dev \
                libmhash2 \
                libc6 \
                libmcrypt-dev \
                libonig-dev \
                libzip-dev \
                zlib1g-dev \
                g++ \
                git \
                vim \
                bzip2 \
        && rm -rf /var/lib/apt/lists/* \
        && docker-php-ext-configure intl \
        && docker-php-ext-install -j$(nproc) mbstring intl zip pdo_mysql pdo_pgsql mysqli opcache soap \
        && docker-php-ext-configure gd --with-freetype --with-jpeg \
        && docker-php-ext-install -j$(nproc) gd

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
                echo 'opcache.memory_consumption=128'; \
                echo 'opcache.interned_strings_buffer=8'; \
                echo 'opcache.max_accelerated_files=4000'; \
                echo 'opcache.revalidate_freq=60'; \
                echo 'opcache.fast_shutdown=1'; \
                echo 'opcache.enable_cli=1'; \
        } > /usr/local/etc/php/conf.d/opcache-recommended.ini
