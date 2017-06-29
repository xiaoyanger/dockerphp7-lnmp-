#!/usr/bin/env bash
# mkdir -p /data/www/wwwroot
service nginx stop
service php-fpm stop
service mysqld stop

service nginx start
service php-fpm start
service mysqld start

mkdir -p /data/server/php/var/log/
mkdir -p /data/server/nginx/logs/
mkdir -p /data/server/mysql/logs/
touch /data/server/php/var/log/php-fpm.log
tail -f /data/server/php/var/log/php-fpm.log
