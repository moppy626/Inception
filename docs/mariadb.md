# mariadb

```
docker container run --name wordpress --rm --interactive --tty --publish 443:80 debian:trixie bash
[コンテナの中]
apt update
apt install -y mariadb-server
mysql -u root --password = -e ""

systemctl start mariadb
```