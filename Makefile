# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmachida <mmachida@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/21 20:26:15 by mmachida          #+#    #+#              #
#    Updated: 2026/04/15 22:37:04 by mmachida         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

BUILDFILE = ./srcs/docker-compose.yml

all:
	docker compose -f $(BUILDFILE) up -d

clean: 
	 docker compose -f $(BUILDFILE) down

fclean: clean

re: fclean all

.PHONY: all clean fclean re
