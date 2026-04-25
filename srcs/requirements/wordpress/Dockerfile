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
		&& rm -rf latest.tar.gz wordpress

COPY www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY wp-config.php /var/www/html/wp-config.php   

CMD 	["/usr/sbin/php-fpm8.2", "-F"]
