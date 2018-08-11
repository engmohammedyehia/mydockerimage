#!/bin/bash

export COMPOSER_ALLOW_SUPERUSER=1
echo "xdebug.remote_host=$XDEBUG_REMOTE_IP" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
/usr/sbin/service php7.2-fpm start
/usr/sbin/service nginx start
/usr/sbin/service memcached start
tail -f /dev/null