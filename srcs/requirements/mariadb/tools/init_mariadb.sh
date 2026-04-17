#!/bin/sh

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
	mysqld --user=mysql &

	until mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1; do
		sleep 1
	done

	mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
	mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
	mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
	mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
	mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
	mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "RENAME USER  'root'@'localhost' TO '$MYSQL_ROOT_USER'@'%';"
	wait
else
	exec mysqld --user=mysql
fi
