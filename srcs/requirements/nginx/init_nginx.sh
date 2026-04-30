#!/bin/sh

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/certs/server.key \
	-out /etc/ssl/certs/server.crt \
	-subj "/C=JP/ST=Tokyo/L=Shinjyuku/O=42Tokyo/OU=student/CN=$DOMAIN_NAME/emailAddress=$WP_ADMIN_MAIL"

exec nginx