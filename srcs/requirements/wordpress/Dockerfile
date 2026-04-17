FROM	debian:trixie

RUN		apt update \
		&& apt install -y php8.4-fpm \
		&& apt install curl -y \
		&& apt install php-mysqli -y \
		&& curl -O https://wordpress.org/latest.tar.gz \
		&& tar xzvf latest.tar.gz \
		&& mkdir /var/www/html -p \
		&& mv wordpress/* /var/www/html \
		&& chown -R www-data:www-data /var/www/html \
		&& rm -rf latest.tar.gz wordpress

COPY www.conf /etc/php/8.4/fpm/pool.d/www.conf
COPY wp-config.php /var/www/html/wp-config.php   

CMD 	["/usr/sbin/php-fpm8.4", "-F"]
