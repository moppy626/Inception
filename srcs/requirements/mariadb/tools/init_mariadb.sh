#!/bin/sh

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then

	cnt=0
	mysqld --user=mysql &
	while (($cnt < 100)) && ! mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1
	do
		sleep 1
		cnt=$((cnt + 1))
	done

	mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
	mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
	mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%';"
	mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
	mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "RENAME USER  'root'@'localhost' TO '$MYSQL_ROOT_USER'@'%';"
	wait
else
	mysqld --user=mysql
fi
