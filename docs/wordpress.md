# WordPressについて
[Ubuntu環境に作成例](https://qiita.com/office_porco/items/196d0871d68ff8b9d1e3)

- Dockerfile設定内容をコマンドで設定してみる
'''
[コンテナの外]
docker container run --name wordpress --rm --interactive --tty --publish 443:80
--mount type=bind,src=/home/mmachida/data/wp_data,dst=/var/www/html \
 debian:trixie bash

[コンテナの中]
apt-get update
apt-get install -y php8.4-fpm
apt-get install curl -y
apt-get install php-mysqli -y
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
mkdir /var/www/html -p
mv wordpress/* /var/www/html
chown -R www-data:www-data /var/www/html
rm -rf latest.tar.gz wordpress

[コンテナの外]
docker cp ./requirements/wordpress/www.conf  wordpress:/etc/php/8.4/fpm/pool.d/www.conf 
docker cp  ./requirements/wordpress/wp-config.php wordpress:/var/www/html/wp-config.php

[コンテナの中]
/usr/sbin/php-fpm8.4 -F
'''

- wordpress内で設定したURLをlocalhostと認識させるために、docker実行環境のhostsファイルに書き込みが必要
'''
 echo "127.0.0.1  mmachida.42.fr" >> /etc/hosts
 '''

 - www-dataとは、linuxでApacheやNginxなどのwebサーバが一般的に利用するユーザグループ

## 参考サイト
[WordPressをDockerとNginxで構築](https://job-info.hateblo.jp/entry/2024/05/09/225138)
[The command line interface for WordPress](https://wp-cli.org/ja/)
[wp-config.php の編集](https://ja.wordpress.org/support/article/editing-wp-config-php/)
[Nginx](https://ja.wordpress.org/support/article/nginx/)
[Ubuntu 22.04 LTS に WordPress 7.4 をインストール](https://qiita.com/cherubim1111/items/b259493a39e36f5d524b)