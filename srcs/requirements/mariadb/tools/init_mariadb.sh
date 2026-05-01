#!/bin/sh

cnt=0
mysqld --user=mysql &
if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
	while [ "$cnt" -lt 100 ] && ! mysqladmin ping --socket=/run/mysqld/mysqld.sock 2>/dev/null
	do
		sleep 1
		cnt=$((cnt + 1))
	done

	mariadb -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
	mariadb -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$(cat /run/secrets/db_password)';"
	mariadb -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%';"
	mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat /run/secrets/db_root_password)';"
fi

wait
