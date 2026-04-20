# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmachida <mmachida@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/21 20:26:15 by mmachida          #+#    #+#              #
#    Updated: 2026/04/20 23:13:49 by mmachida         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

BUILDFILE = ./srcs/docker-compose.yml

up:
	docker compose -f $(BUILDFILE) up -d

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
