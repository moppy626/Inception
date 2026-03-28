# mariadb

```
docker container run --name wordpress --rm --interactive --tty --publish 443:80 debian:trixie bash
[コンテナの中]
apt update
apt install mariadb-server mariadb-client galera-4

systemctl start mariadb
```