# WordPressについて
[Ubuntu環境に作成例](https://qiita.com/office_porco/items/196d0871d68ff8b9d1e3)

'''
docker container run --name wordpress --rm --interactive --tty --publish 443:80 debian:trixie bash
[コンテナの中]
apt update
apt install -y php8.4-fpm
apt install curl -y
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
mkdir /var/www/html -p
mv wordpress /var/www/html
chown -R www-data:www-data /var/www/html

[コンテナの外]
docker cp ./requirements/wordpress/www.conf  wordpress:/etc/php/8.4/fpm/pool.d/www.conf 

[コンテナの中]
/usr/sbin/php-fpm8.4 -F
'''

## 参考サイト
[WordPressをDockerとNginxで構築](https://job-info.hateblo.jp/entry/2024/05/09/225138)
[The command line interface for WordPress](https://wp-cli.org/ja/)
[wp-config.php の編集](https://ja.wordpress.org/support/article/editing-wp-config-php/)
[Nginx](https://ja.wordpress.org/support/article/nginx/)
[Ubuntu 22.04 LTS に WordPress 7.4 をインストール](https://qiita.com/cherubim1111/items/b259493a39e36f5d524b)