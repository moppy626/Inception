FROM	debian:bookworm

RUN		apt-get update \
		&& apt-get install -y mariadb-server \
		&& mkdir -p /run/mysqld \
		&& chown mysql:mysql /run/mysqld

COPY	conf/my.conf /etc/mysql/my.cnf

COPY	tools/init_mariadb.sh /init_mariadb.sh
RUN		chmod +x /init_mariadb.sh \
 		&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/init_mariadb.sh"]
