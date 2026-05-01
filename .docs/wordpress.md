# WordPressについて
[Ubuntu環境に作成例](https://qiita.com/office_porco/items/196d0871d68ff8b9d1e3)

- Dockerfile設定内容をコマンドで設定してみる

'''
[コンテナの外]
docker container run --name wordpress --rm --interactive --tty --publish 443:80 \
--mount type=bind,src=/home/mmachida/data/wp_data,dst=/var/www/html \
 debian:bookworm bash

[コンテナの中]
apt-get update
apt-get install -y php8.2-fpm
apt-get install curl -y
apt-get install php8.2-mysqli -y
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
mkdir /var/www/html -p
mv wordpress/* /var/www/html -n
chown -R www-data:www-data /var/www/html
rm -rf latest.tar.gz wordpress


curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp core download --locale=ja --allow-root
wp core install --url=http://example.com/ --title=test --admin_user=wordpress_user --admin_password=password --admin_email=test@example.com --allow-root
wp user create "user" "test@mail.com" --user_pass="pass" --role="role" --allow-root


[コンテナの外]
docker cp ./requirements/wordpress/www.conf  wordpress:/etc/php/8.2/fpm/pool.d/www.conf 
docker cp  ./requirements/wordpress/wp-config.php wordpress:/var/www/html/wp-config.php

[コンテナの中]
/usr/sbin/php-fpm8.2 -F
'''

- wordpress内で設定したURLをlocalhostと認識させるために、docker実行環境のhostsファイルに書き込みが必要

'''
 echo "127.0.0.1  mmachida.42.fr" >> /etc/hosts
'''

 - www-dataとは、linuxでApacheやNginxなどのwebサーバが一般的に利用するユーザグループ

 ## www.conf
 ```
 [www]
# 参考) https://www.php.net/manual/ja/install.fpm.configuration.php
# PHP-FPM プロセスを実行するユーザーとグループ。セキュリティやファイル権限の管理で使用される
user = www-data
group = www-data
# PHP-FPM がリクエストを受け付けるIPとポート。nginx.confの設定と合わせる
listen = 0.0.0.0:9000
listen.owner = www-data
listen.group = www-data
# プロセス数をリクエストに応じて増減させる（single dynamic static のいずれか）
pm = dynamic
# 同時に処理できる子プロセスの上限。PHP-FPMは、事前に起動しておいた子プロセス（PHP実行担当）がリクエストを処理する。
pm.max_children = 5
# PHP-FPM 起動時に、最初に立ち上げる子プロセスの数。
pm.start_servers = 2
# 待機中子プロセスの最小数。少なすぎる場合は自動で増やされる
pm.min_spare_servers = 1
# 待機中の子プロセスの最大数。多すぎる場合は自動で減らされる
pm.max_spare_servers = 3
# FastCGI の statusリクエスト を受け付けるアドレス
pm.status_listen = wordpress:9000
# ワーカーの標準出力および標準エラー出力を本体のエラーログにリダイレクトします
catch_workers_output = yes
# 任意の環境変数が FPM ワーカープロセスに到達してしまうことを防ぐために、 ワーカー内の環境をいったんクリアしてから、このプールの設定で指定された環境変数を追加します
clear_env = no
```

## 参考サイト
[WordPressをDockerとNginxで構築](https://job-info.hateblo.jp/entry/2024/05/09/225138)
[The command line interface for WordPress](https://wp-cli.org/ja/)
[wp-config.php の編集](https://ja.wordpress.org/support/article/editing-wp-config-php/)
[Nginx](https://ja.wordpress.org/support/article/nginx/)
[Ubuntu 22.04 LTS に WordPress 7.4 をインストール](https://qiita.com/cherubim1111/items/b259493a39e36f5d524b)
[WP-CLIの使い方](https://qiita.com/IK12_info/items/4a9190119be2a0f347a0)
