#!/bin/sh

cnt=0
mysqld --user=mysql &
while [ "$cnt" -lt 100 ] && ! mysqladmin ping -h localhost -u root -p"$(cat /run/secrets/db_root_password)"
do
	sleep 1
	cnt=$((cnt + 1))
done

mariadb -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mariadb -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$(cat /run/secrets/db_password)';"
mariadb -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%';"

wait
