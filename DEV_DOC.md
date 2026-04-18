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

## Data  
Since this is created as a Docker volume while specifying a storage location on the host, you can store data in the same way as with a bind mount.
The data is stored under `/home/mmachida/data/`.
If you want to initialize the volume's contents, run `docker-compose down -v` in the `srcs` directory. This will initialize the data.

## Info  
- [WordPressのデータベースの中身はどうなっているのか？](https://wpmake.jp/contents/security/database/)
