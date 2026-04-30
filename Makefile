# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmachida <mmachida@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/21 20:26:15 by mmachida          #+#    #+#              #
#    Updated: 2026/05/01 00:35:49 by mmachida         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

BUILDFILE = ./srcs/docker-compose.yml
LOCALPATH = /home/mmachida/data/

all: prepare up

prepare:
	- @mkdir -p $(LOCALPATH)db_data
	- @mkdir -p $(LOCALPATH)wp_data
	- @sudo chmod -R 755 $(LOCALPATH)db_data
	- @sudo chmod -R 755 $(LOCALPATH)wp_data

pass:
	if [ ! -d secrets ]; then \
		mkdir secrets; \
	fi; \
	if [ ! -e secrets/credentials.txt ]; then \
		echo "WP_ADMIN_PASS=$$(more /dev/urandom  | tr -d -c '[:alnum:]' | fold -w 10 | head -1)" > secrets/credentials.txt; \
		echo "WP_PASS=$$(more /dev/urandom  | tr -d -c '[:alnum:]' | fold -w 10 | head -1)" >> secrets/credentials.txt; \
	fi; \
	if [ ! -e secrets/db_password.txt ]; then \
		echo $$(more /dev/urandom  | tr -d -c '[:alnum:]' | fold -w 10 | head -1) > secrets/db_password.txt; \
	fi; \
	if [ ! -e secrets/db_root_password.txt ]; then \
		echo $$(more /dev/urandom  | tr -d -c '[:alnum:]' | fold -w 10 | head -1) > secrets/db_root_password.txt; \
	fi; \
	
up:
	docker compose -f $(BUILDFILE) up

stop:
	 docker compose -f $(BUILDFILE) stop

down: 
	 docker compose -f $(BUILDFILE) down

build:
	docker compose -f $(BUILDFILE) build --no-cache

mariadb:
	docker compose -f $(BUILDFILE) exec mariadb bin/bash 

wordpress:
	docker compose -f $(BUILDFILE) exec wordpress bin/bash 

nginx:
	docker compose -f $(BUILDFILE) exec nginx bin/bash 

clean:
	- docker system prune
	- docker compose -f $(BUILDFILE) down -v>/dev/null 2>&1
	- docker stop $(docker ps -qa)>/dev/null 2>&1
	- docker rm $(docker ps -qa)>/dev/null 2>&1
	- docker rmi -f $(docker images -qa)>/dev/null 2>&1
	- docker volume rm $(docker volume ls -q)>/dev/null 2>&1
	- docker network rm $(docker network ls -q)>/dev/null 2>&1
	- sudo rm -rf $(LOCALPATH)db_data/*>/dev/null 2>&1
	- sudo rm -rf $(LOCALPATH)wp_data/*>/dev/null 2>&1

test:
	curl -k https://mmachida.42.fr
