#!/bin/sh

. /run/secrets/credentials

cnt=0
while [ "$cnt" -lt 100 ] && ! mysqladmin ping -h mariadb --silent
do
	sleep 1
	cnt=$((cnt + 1))
done

cd /var/www/html
wp core install --url="$DOMAIN_NAME" --title="$SITE_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASS" --admin_email="$WP_ADMIN_MAIL" --allow-root 
wp user create "$WP_USER" "$WP_USER_MAIL" --user_pass="$WP_PASS" --role="$WP_ROLE_AUTHOR" --allow-root

exec /usr/sbin/php-fpm8.2 -F
