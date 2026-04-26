FROM	debian:bookworm

RUN		apt-get update \
		&& apt-get install -y php8.2-fpm \
		&& apt-get install curl -y \
		&& apt-get install php8.2-mysqli -y \
		&& curl -O https://wordpress.org/latest.tar.gz \
		&& tar xzvf latest.tar.gz \
		&& mkdir /var/www/html -p \
		&& mv wordpress/* /var/www/html \
		&& chown -R www-data:www-data /var/www/html \
		&& rm -rf latest.tar.gz wordpress \

COPY www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY wp-config.php /var/www/html/wp-config.php   

RUN		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
RUN		chmod +x wp-cli.phar 
RUN		mv wp-cli.phar /usr/local/bin/wp 
RUN		wp core download --locale=ja --allow-root 
# RUN		wp core install --url=http://example.com/ --title=test --admin_user=wordpress_user --admin_password=password --admin_email=test@example.com --allow-root 
# RUN		wp user create "user" "test@mail.com" --user_pass="pass" --role="role" --allow-root

CMD 	["/usr/sbin/php-fpm8.2", "-F"]
