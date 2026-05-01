#!/bin/sh

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/certs/server.key \
	-out /etc/ssl/certs/server.crt \
	-subj "/C=JP/ST=Tokyo/L=Shinjyuku/O=42Tokyo/OU=student/CN=$DOMAIN_NAME/emailAddress=$WP_ADMIN_MAIL"

# netcatコマンド -z データ送信なしで接続確認
cnt=0
while [ "$cnt" -lt 100 ] && ! nc -z wordpress 9000
do
	sleep 1
done

exec nginx