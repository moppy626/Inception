# mariadb

```
docker container run --name wordpress --rm --interactive --tty --publish 443:80 \
--mount type=bind,src=$(pwd)/requirements/mariadb/tools/init.sql,dst=/init.sql \
debian:trixie bash
[コンテナの中]
apt update
apt install -y mariadb-server mariadb-client
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld
mysqld --user=mysql --init-file=/init.sql



```

## mariadb-install-db
- MariaDBのデータディレクトリを初期化し、システムテーブルが存在しない場合は作成します
- ```--user
- ```--datadir

## mysqldの起動オプション
- --init-file

## SQL
- CREATE USER
- GRANT
- 認証方式
