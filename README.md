# Inception
## image
Nginxはリバースプロキシ
* [Ubuntu 20.04にNginxをインストールする方法](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04-ja)
* [Official build of Nginx.](https://hub.docker.com/_/nginx)
* [Nginx SSL/TLS設定を TLS 1.2と1.3に変更](https://arakoki70.com/?p=5781)
* [nginx連載6回目: nginxの設定、その4 - TLS/SSLの設定}(https://heartbeats.jp/hbblog/2012/06/nginx06.html)
* [nginx ドキュメント日本語訳](https://mogile.web.fc2.com/nginx/docs/)
* nginx
```
docker container run --name nginx --rm --interactive --tty --publish 443:80 debian:trixie bash
apt update
apt install -y nginx
service nginx start
/etc/nginx/nginx.conf
```
* wordpress
```
docker container run --name nginx --rm --interactive --tty --publish 443:80 debian:trixie bash
apt update
apt install -y php
