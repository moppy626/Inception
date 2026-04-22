# Nginx
* Nginxはリバースプロキシ

```
[コンテナ外]
docker container run --name nginx --rm --interactive --tty --publish 443:80 \
--mount type=bind,src=/home/mmachida/data/wp_data,dst=/var/www/html \
debian:trixie \
bash 

[コンテナ内]
apt-get update
apt-get -y install nginx
apt-get install -y openssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/certs/server.key \
	-out /etc/ssl/certs/server.crt \
	-subj "/C=JP/ST=Tokyo/L=Shinjyuku/O=42Tokyo/CN=mmachida.42.fr"

[コンテナ外]
docker cp ./requirements/nginx/conf/nginx.conf nginx:/etc/nginx/nginx.conf

[コンテナ中]
nginx

```
# SSLについて
## SSL証明書について
通常は第三者の機関である認証局にCA証明書の発行を依頼して、そのサイトがなりすましや偽物でなく、本物であることの証明をしてもらう。
httpsは、httpの通信を通信を暗号化したもの。

- 自己証明書
	今回は学習用なので公的な証明書発行は依頼せず、自身のPC内のNginxコンテナ内で証明書を発行する。  

- CA証明書
	ブラウザの内部に登録されているルート証明書が証明するCAが発行している
	- DV証明書(ドメイン認証)...無料～。ドメインの所有権のみ証明する。
	- OV証明書(企業認証)...年間4万円～。ドメインが合法的に登録された企業のものであることを証明する。
	- EV証明書(実在証明拡張)...年間5万円～。ガイドラインに基づきセキュリティ対策が実施されている安全なサイトかどうか審査が行ったうえで発行される。
- [SSL/TLSサイバー証明書の基礎知識](https://www.cybertrust.co.jp/blog/ssl/knowledge/ssl-basics.html)

## OpenSSLについて
自己認証局が作れる無料のツール。他にもハッシュ化したり暗号化・復号化したり、いろいろな機能がある。
- req...認証局に証明書を発行してもらうための申請書(CSR)の作成をするコマンド。これを認証局に送って署名してもらう。
- x509...デジタル証明書の国際規格。これをつけることで、その場で自分で署名まで完了させて完成した証明書(x509形式)として出力する。
- nodes...NO DES。秘密鍵をパスワードなしでつくる。これをつけないと聞かれるので自動化のために指定。
- newkey...新しい秘密鍵を生成するオプション。つけないと既存の秘密鍵を使う前提になる。鍵の長さはデフォルトで「rsa:2048」
- keyout...生成する秘密鍵のパスを指定するオプション。nginx.confと合わせる。
- out...秘密鍵を保存するファイル名を指定する。デフォルトだと標準出力にしか出ない。nginx.confと合わせる。
- subj...初期設定の内容を指定するオプション。指定しないと起動時に聞かれるので自動化のために指定。
	- CN...発行する証明書の中に書き込む「どのホスト名に対してこの証明書が有効か」を指定するもの。この
- [OpenSSL Command-Line HOWTO](https://nona.to/fswiki/OpenSSL+Command-Line+HOWTO.html)

## 参考
* [Nginx SSL/TLS設定を TLS 1.2と1.3に変更](https://arakoki70.com/?p=5781)
* [nginx連載6回目: nginxの設定、その4 - TLS/SSLの設定](https://heartbeats.jp/hbblog/2012/06/nginx06.html)
* [Nginxの自己署名証明書によるHTTPS化](https://kkspecial.hatenablog.com/entry/2025/09/14/223630)

# nginx.confについて
- try_files $uri $uri/ /index.php?$args;
	最初に$uriというファイルがあるか探し、次にディレクトリとして探し、なければindex.phpを返す
- location ~ \.php$
	拡張子が.phpだったらすべて当てはまる
- include fastcgi_params;
	FastCGI の環境変数を設定するファイル (/etc/nginx/fastcgi_params) を読み込みます。
	fastcgi_paramでここに足りない変数を追加します。
	- SCRIPT_FILENAME:どのPHPファイルを動かすか
	- PATH_INFO:その後ろの情報
- fastcgi_pass wordpress:9000;
	wordpressコンテナのPHP-FPMデフォルト待ち受けポートに転送
## 参考
* [Ubuntu 20.04にNginxをインストールする方法](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04-ja)
* [Official build of Nginx.](https://hub.docker.com/_/nginx)
* [nginx ドキュメント日本語訳](https://mogile.web.fc2.com/nginx/docs/)
* [入門 - Nginx + PHP-FPM の仕組み](https://zenn.dev/azunyan/articles/0dad881616063b)
