# mariadb

```
[コンテナの外]
docker container run --name wordpress --rm --interactive --tty --publish 443:80 \
--mount type=bind,src=/home/mmachida/data/db_data,dst=/var/lib/mysql \
debian:trixie bash

[コンテナの中]
apt update
apt install -y mariadb-server mariadb-client
mkdir -p /run/mysqld

[コンテナの外]
docker cp ./requirements/mariadb/tools/init_mariadb.sh mariadb:/init_mariadb.sh
docker cp ./requirements/mariadb/conf/my.cnf mariadb:/etc/mysql/my.cnf

[コンテナの中]
chown mysql:mysql /run/mysqld
chmod +x /init_mariadb.sh
./init_mariadb.sh

```
