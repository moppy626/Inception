# mariadb

```
[コンテナの外]
docker container run --name wordpress --rm --interactive --tty --publish 443:80 \
--mount type=bind,src=/home/mmachida/data/db_data,dst=/var/lib/mysql \
debian:trixie bash

[コンテナの中]
apt-get update
apt-get install -y mariadb-server mariadb-client
mkdir -p /run/mysqld

[コンテナの外]
docker cp ./requirements/mariadb/tools/init_mariadb.sh mariadb:/init_mariadb.sh
docker cp ./requirements/mariadb/conf/my.cnf mariadb:/etc/mysql/my.cnf

[コンテナの中]
chown mysql:mysql /run/mysqld
chmod +x /init_mariadb.sh
./init_mariadb.sh

```

## my.confについて
- /etc/my.cnfや/etc/mysql/my.cnfなどに配置して、[コマンドの起動時](https://qiita.com/yoheiW@github/items/bcbcd11e89bfc7d7f3ff)に指定する値を設定できる
- bind-address  
	どのアドレスからの接続を待ち受けするのかを指定する。デフォルトではローカルホスト(127.0.0.1)しか受け付けない。
	0.0.0.0はすべてを受け付けるという意味。
	参考：[MySQLで外部ホストから接続する](https://qiita.com/tsuzuki_takaaki/items/abe481d9645e1121f2a8)
- innodb_use_native_aio  
	Linuxにある高速I/O機能(io_uring)を使うかどうかの設定。
	デフォルトだと使用しようとするが、権限などの関係でコンテナ環境でエラーになり、ワーニングを出力して別の接続方法に自動で切り替わるためオフにした
	参考：[15.8.6 Linux での非同期 I/O の使用](https://docs.oracle.com/cd/E17952_01/mysql-8.0-ja/innodb-linux-native-aio.html)

## init_mariadb.shについて
- mysqld
	```--user=mysql``` mysqlはLinuxのユーザで、データベースサーバを立ち上げるために使用している。/var/lib/mysql などDB関連のファイル以外はデフォルトでは操作できない。
	```&```の意味 mysqldは立ち上げると終了せず動き続けるコマンドである。そのため&でつなげてwhileループを同時実行して、続きが実行されるようにする
- mariadb
	```-uroot``` DB内の管理者ですべての操作が可能なユーザ。
	```-e``` 指定したSQLを実行してすぐ終了するオプション
	```2>&1``` 標準エラー出力(2)を、ファイルディスクリプタ1(&1)に送るので、標準出力と同じ行先になる
- 実行SQL
	```GRANT```権限の種類 [こちら](https://blog.katsubemakito.net/mysql/grant)がすべて

## ```/run/mysqld/mysqld.sock``について
	フォルダを作成して権限を付与しないと以下のようなエラーになる
	```
	2026-04-21 19:55:37 0 [ERROR] Can't start server : Bind on unix socket: No such file or directory
	2026-04-21 19:55:37 0 [ERROR] Do you already have another server running on socket: /run/mysqld/mysqld.sock ?
	2026-04-21 19:55:37 0 [ERROR] Aborting
	```
