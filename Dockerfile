FROM ubuntu:18.10

MAINTAINER Mohammed Yehia <firefoxegy@gmail.com>

# update the system
RUN DEBIAN_FRONTEND=noninteractive apt-get update

# install common packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nano wget curl vim zip unzip git software-properties-common locales

# locales to UTF8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# install nginx
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx

RUN DEBIAN_FRONTEND=noninteractive apt-get update

# install php7.2 and all required extensions
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php7.2 php7.2-mysql php7.2-curl php7.2-json php7.2-gd php7.2-intl php-pear php-imagick php7.2-imap php7.2-memcached  php7.2-pspell php7.2-recode php7.2-sqlite3 php7.2-tidy php7.2-xmlrpc php7.2-xsl php7.2-mbstring php7.2-bcmath php7.2-dev php7.2-fpm php7.2-zip php-gettext libz-dev

# install xdebug
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php-xdebug

<<<<<<< HEAD
=======
# install redis 
RUN pecl channel-update pecl.php.net
RUN pecl install redis
RUN echo "extension=/usr/lib/php/20170718/redis.so" > /etc/php/7.2/mods-available/redis.ini
RUN ln -sf /etc/php/7.2/mods-available/redis.ini /etc/php/7.2/fpm/conf.d/20-redis.ini
RUN ln -sf /etc/php/7.2/mods-available/redis.ini /etc/php/7.2/cli/conf.d/20-redis.ini

RUN pecl install igbinary
RUN echo "extension=/usr/lib/php/20170718/igbinary.so" > /etc/php/7.2/mods-available/igbinary.ini
RUN ln -sf /etc/php/7.2/mods-available/igbinary.ini /etc/php/7.2/fpm/conf.d/20-igbinary.ini
RUN ln -sf /etc/php/7.2/mods-available/igbinary.ini /etc/php/7.2/cli/conf.d/20-igbinary.ini

# install composer
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && rm -rf /var/lib/apt/lists/*

>>>>>>> 1b90426603bb59423011edf51a51d8f6c6424d53
# copy the nginx configuration
ADD default.conf   /etc/nginx/sites-available/default

# add ssl certificates to use with nginx
RUN mkdir /etc/nginx/ssl
ADD localhost.crt   /etc/nginx/ssl/localhost.crt
ADD localhost.key   /etc/nginx/ssl/localhost.key

RUN echo "xdebug.remote_enable=1" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
RUN echo "xdebug.remote_port=9005" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
RUN echo "xdebug.remote_autostart=1" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
RUN echo "xdebug.remote_connect_back=0" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
<<<<<<< HEAD
RUN echo "xdebug.idekey=PHPSTORM2" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
RUN echo "xdebug.remote_host=host.docker.internal" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini

# Increase memory limit for php, upload limit and some other tweeks
RUN sed -i -e "s/memory_limit\s*=\s*128M/memory_limit = 512M/g" /etc/php/7.2/fpm/php.ini
RUN sed -i -e "s/;\s*max_input_vars\s*=\s*1000/max_input_vars = 1000/g" /etc/php/7.2/fpm/php.ini
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 200M/g" /etc/php/7.2/fpm/php.ini
RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 201M/g" /etc/php/7.2/fpm/php.ini
=======
RUN echo "xdebug.remote_host=host.docker.internal" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
RUN echo "xdebug.profiler_enable=1" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
RUN echo "xdebug.profiler_output_dir=/var/www/html/data/profiler" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
RUN echo "xdebug.idekey=PHPSTORM" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
RUN echo "xdebug.force_display_errors=1" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
>>>>>>> 1b90426603bb59423011edf51a51d8f6c6424d53

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80 443

COPY start.sh .
WORKDIR .
RUN chmod +x start.sh
ENTRYPOINT ["/start.sh"]
CMD ["nginx", "-g", "daemon off;"]
WORKDIR /var/www/html
