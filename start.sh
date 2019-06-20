#!/bin/bash

export COMPOSER_ALLOW_SUPERUSER=1
/usr/sbin/service php7.2-fpm start
/usr/sbin/service nginx start
/usr/sbin/service memcached start
tail -f /dev/null