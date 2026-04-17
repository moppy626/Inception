FROM	debian:trixie

RUN		apt update \
		&& apt -y install nginx \
		&& apt install -y openssl \
		&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-keyout /etc/ssl/certs/server.key \
			-out /etc/ssl/certs/server.crt \
			-subj "/C=JP/ST=Tokyo/L=Shinjyuku/O=42Tokyo/CN=$DOMAIN_NAME"			

COPY	conf/nginx.conf /etc/nginx/nginx.conf

CMD 	["nginx"]
