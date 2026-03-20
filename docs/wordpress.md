# WordPressについて
[Ubuntu環境に作成例](https://qiita.com/office_porco/items/196d0871d68ff8b9d1e3)

'''
docker container run --name nginx --rm --interactive --tty --publish 443:80 debian:trixie bash
apt update
apt install curl
apt install php libapache2-mod-php php-mysql -y
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
sudo mv wordpress /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

'''

## 参考サイト
[WordPressをDockerとNginxで構築](https://job-info.hateblo.jp/entry/2024/05/09/225138)
[The command line interface for WordPress](https://wp-cli.org/ja/)
[wp-config.php の編集](https://ja.wordpress.org/support/article/editing-wp-config-php/)
[Nginx](https://ja.wordpress.org/support/article/nginx/)
