# WordPressについて
[Ubuntu環境に作成例](https://qiita.com/office_porco/items/196d0871d68ff8b9d1e3)
[WordPressをDockerとNginxで構築](https://job-info.hateblo.jp/entry/2024/05/09/225138)

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

```
version: '3'

services:
  db:
    image: mysql:5.7 # mysqlのバージョンは適宜変えてください
    volumes:
   - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: examplepassword
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: examplepassword

  wordpress:
    depends_on:
   - db
    image: wordpress:latest
    volumes:
   - ./wordpress:/var/www/html
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: examplepassword
      WORDPRESS_DB_NAME: wordpress
    ports:
   - "8000:80"

  nginx:
    image: nginx:latest
    ports:
   - "80:80"
    volumes:
   - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
   - wordpress

volumes:
  db_data:
  ```

## 参考サイト
[The command line interface for WordPress](https://wp-cli.org/ja/)
[wp-config.php の編集](https://ja.wordpress.org/support/article/editing-wp-config-php/)
[Nginx](https://ja.wordpress.org/support/article/nginx/)
