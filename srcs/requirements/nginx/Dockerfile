FROM	debian:bookworm

RUN		apt-get update \
		&& apt-get -y install nginx \
		&& apt-get install -y openssl \
		&& apt-get install -y netcat-openbsd \
		&& rm -rf /var/lib/apt/lists/* 

COPY	conf/nginx.conf /etc/nginx/nginx.conf
COPY	init_nginx.sh /init_nginx.sh
RUN		chmod +x /init_nginx.sh

ENTRYPOINT 	["/init_nginx.sh"]
