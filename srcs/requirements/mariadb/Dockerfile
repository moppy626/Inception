FROM	debian:trixie

COPY	tools/init_mariadb.sh /init_mariadb.sh
COPY	conf/my.conf /etc/mysql/my.cnf
RUN		apt-get update \
		&& apt-get install -y mariadb-server mariadb-client \
		&& mkdir -p /run/mysqld \
		&& chown mysql:mysql /run/mysqld \
		&& chmod +x /init_mariadb.sh

CMD ["/init_mariadb.sh"]
