# Description for developer

## Composition
```
├── DEV_DOC.md
├── Makefile
├── README.md
├── USER_DOC.md
├── secrets
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
└── srcs
    ├── docker-compose.yml
    └── requirements
        ├── mariadb
        │   ├── Dockerfile
        │   ├── conf
        │   │   └── my.conf
        │   └── tools
        │       └── init_mariadb.sh
        ├── nginx
        │   ├── Dockerfile
        │   └── conf
        │       └── nginx.conf
        └── wordpress
            ├── Dockerfile
            ├── wp-config.php
            └── www.conf
```

- README.md DEV_DOC.md USER_DOC.md  
This document provides an explanation of the project.
- Makefile
Start or stop Docker Compose  
- secrets  
This file contains database passwords and authentication keys. Since it is not included in the Git repository, please configure it separately.  
- docker-compose.yml  
Create containers for MariaDB, Nginx, and WordPress using the Dockerfiles located in their respective folders, connect them via the network, configure the volumes, and start them.  
- mariadb  
Install MariaDB and place the my.conf file in the folder. Run init_mariadb.sh to start mysqld. Only on the first startup, create a database for WordPress, create a user, and change the username and password for the default admin user.
- nginx  
Install Nginx and OpenSSL, and generate an SSH key. Place the nginx.conf file containing the server configuration settings, and start Nginx.
- wordpress  
Install PHP-FPM, WordPress, and php-mysqli. Place the wp-config.php file, which contains database access information, and the www.conf file, which contains WordPress configuration information, in the appropriate directories.

## Prerequisites
- Docker must be installed on your system
- 64-bit CPU
- 8 GB or more of RAM
- 4 GB or more of storage

## Setup Instructions
1. Clone this Git repository to a system where Docker is installed.
2. Place the file containing the database password in the ‘secrets’ folder located directly under the git directory.
Alternatively, run ```make pass``` to generate a new random password.
3. Run the ‘make’ command in the directory directly under the repository. This will start the Docker containers.
4. Go to https://mmachida.42.fr:443. The WordPress dashboard will appear in your browser. Try posting a message on the forum.
5. You can access the admin page at https://mmachida.42.fr:443/wp-admin/. 
6. To stop the process, run `make down` in the directory directly under Git. This will remove all created containers.
7. Please verify that the data you created remains intact even after restarting the containers or shutting down the host PC.

## Makefile
- make prepare ... Creates the necessary folders for the runtime environment and sets permissions
- make pass... Automatically generates passwords for the DB and WordPress used by the containers
- make up... Runs `docker compose up`. Starts the MariaDB, WordPress and Nginx Docker containers respectively
- make stop... Runs `docker compose stop` to stop each container
- make down... Runs `docker compose down`. Stops and deletes each container
- make build... Runs `docker compose build`. This performs a build without using the cache; please use this if changes to files are not being reflected
- make mariadb, wordpress, nginx... Run `docker compose exec bash`. This allows you to execute commands within the containers.
- make clean... Clears all data, including the contents of the database.
- make test... https://mmachida.42.frに対してcurlコマンドを送ることができます

## Data Persistence  
This is created as a Docker volume by specifying a storage location on the host, so data can be stored in the same way as with a bind mount.
Data is stored under `/home/mmachida/data/`.
If you wish to initialise the contents of the volume, run `docker-compose down -v` in the `srcs` directory. This will initialise the data.

## Info  
- [WordPressのデータベースの中身はどうなっているのか？](https://wpmake.jp/contents/security/database/)
