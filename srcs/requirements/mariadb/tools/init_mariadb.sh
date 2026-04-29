#!/bin/sh

cnt=0
mysqld --user=mysql &
while [ "$cnt" -lt 100 ] && ! mysqladmin ping --socket=/run/mysqld/mysqld.sock 2>/dev/null
do
	sleep 1
	cnt=$((cnt + 1))
done

mariadb --socket=/run/mysqld/mysqld.sock -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mariadb --socket=/run/mysqld/mysqld.sock -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$(cat /run/secrets/db_password)';"
mariadb --socket=/run/mysqld/mysqld.sock -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%';"

wait
