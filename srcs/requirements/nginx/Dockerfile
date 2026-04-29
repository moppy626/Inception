FROM	debian:bookworm

RUN		apt-get update \
		&& apt-get -y install nginx \
		&& apt-get install -y openssl \
		
		&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-keyout /etc/ssl/certs/server.key \
			-out /etc/ssl/certs/server.crt \
			-subj "/C=JP/ST=Tokyo/L=Shinjyuku/O=42Tokyo/CN=$DOMAIN_NAME" \ 
		&& rm -rf /var/lib/apt/lists/* 

COPY	conf/nginx.conf /etc/nginx/nginx.conf

CMD 	["nginx"]
