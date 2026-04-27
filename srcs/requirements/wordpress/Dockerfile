FROM	debian:bookworm

RUN		apt-get update \
		&& apt-get install -y php8.2-fpm \
		&& apt-get install curl -y \
		&& apt-get install php8.2-mysqli -y \
		&& apt-get install -y mariadb-client \
		&& curl -O https://wordpress.org/latest.tar.gz \
		&& tar xzvf latest.tar.gz \
		&& mkdir /var/www/html -p \
		&& mv wordpress/* /var/www/html \
		&& chown -R www-data:www-data /var/www/html \
		&& rm -rf latest.tar.gz wordpress

COPY 	www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY 	wp-config.php /var/www/html/wp-config.php   
COPY	init_wordpress.sh /init_wordpress.sh

RUN		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  \
		&& chmod +x wp-cli.phar  \
		&& mv wp-cli.phar /usr/local/bin/wp  \
		&& chmod +x /init_wordpress.sh
		&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["./init_wordpress.sh"]
