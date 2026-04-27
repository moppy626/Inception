# NGINXの設定ファイル（serverブロック）を調べる

## nginx.confとは?
デフォルトの設定だと/etc/nginxにできるファイル。conf.dというサブディレクトリに作ることもある。  
```
	/* coreモジュールの設定 */

	events {
		/* eventモジュールの設定 */
	}

	mail {
		/* mailモジュールの設定 */
	}

	http {
		/* httpモジュールの設定 */
		# ⑤リクエストボディのサイズ上限
		client_max_body_size 100m;

		server {
			/* serverコンテキスト */

			# ①IPアドレス:ポート番号
			listen       192.0.2.1:80;
			# ②サーバの名前
			server_name  example.com;
			location /example/ {
				/* ③locationコンテキスト */
				root   /usr/share/nginx/html;
				index  index.html index.htm;

				# ⑥許可 HTTP メソッド
				limit_except GET POST { 
					allow 192.168.1.0/24; 
					deny all; 
				}
			}
			location = /50x.html {
				root   /usr/share/nginx/html;
			}
			# ⑧ディレクトリリスト表示
			location /images/ {
				autoindex on;
			}
			# ⑨CGI 実行
			location ~ \.php$ {
				fastcgi_pass unix:/run/php/php-fpm.sock;
			}

			# ④エラーページ
			error_page   500 502 503 504  /50x.html;
			# ⑩ファイルアップロードの指定
			client_body_temp_path /spool/nginx/client_temp;
		}

		# ⑦HTTPリダイレクト
		server {
			listen 80;
			server_name test.com;
			return 301 https://$host$request_uri;
		}
	}
```

<br>
<br>

## 凡例
```
✅ = 課題で実装が必要な項目
⬜ = NGINXにはあるが補足情報（実装不要 or 要検討）
```

## ①IPアドレス:ポート番号
```
	listen       192.0.2.1:80;
```
✅ webservのプログラム内で以下のように使用することで、リクエストを受け付けるIPアドレスやポート番号あるいはUNIXドメインソケットを設定できる。  
```
	socket();
	bind(IPアドレス,　ポート番号);
	listen();
```
⬜ serverディレクティブに設定できる   
⬜ どちらかを省略するとデフォルト値になる。  
⬜ IPアドレスのデフォルト値はすべてのインターフェイス アドレスを意味する"*","0.0.0.0"であり、ポート番号のデフォルト値は"80"になる。そのため、listenディレクティブを省略すると、```listen *:80;```と同じになる。  
⬜ IPv6の場合は```listen [2001:db8:dead:beef::1]:80;```のような角括弧で囲む記法を使う。  

⬜ また、「UNIXドメインソケット」という同一PC内でしか通信できない名前付きPIPEのようなものが存在するが、Nginxでは```listen unix:/var/run/nginx.sock;```のように記述するとUNIXドメインソケットでもリクエストを受け付けることができる。記述方法は"listen unix:UNIXドメインソケットのパス"である。  

<br>
<br>

## ②サーバの名前
```
	server_name  example.com;
```
✅ Nginx.confには複数のサーバを設定できるが、Nginxはリクエストを受け取ると、[リクエスト](#HTTPリクエストの一例)のデータの中にあるホスト名がこのserver_nameディレクティブに一致するサーバーを選ぶ。Webservの実装では、パスを文字列比較して判定する。  
⬜ serverディレクティブに設定できる  
⬜ スペース区切りで複数指定できる。  
⬜ サブドメインに全て一致させるには、```server_name *.example.com;```もしくは```server_name .example.com;```のように指定する。  ```server_name ~^www\d+\.example\.com$;```のように正規表現を使って記述することもできる。空を意味する""を設定すると、Hostヘッダフィールドがない場合に一致する(server_nameディレクティブのデフォルト値)。  
⬜ DNSで名前解決が行われた場合でも、HTTPヘッダのHostには「アクセスに使ったホスト名」が入るため、それと一致させないと受け付けない。localhostと書いた場合には、127.0.0.1でアクセスした場合はヒットしないもよう。  
⬜ どのサーバ名とも一致しない場合、IPアドレスとポート番号の条件が一致したもののうち、以下のように、サーバーのlistenに```default_server```と書かれているものが選ばれる。  
```
	listen *:80 default_server;
```
⬜ どこにもdefault_serverが指定されていない場合には、最初にIPアドレスとポート番号の条件に一致したサーバーが選ばれる（読み込まれる順番は不定）。  
<br>
<br>

## ③locationコンテキスト
```
	location /example/ {
		root   /usr/share/nginx/html;
	}
```
✅ 上記の例だと、リクエストURIのパスの先頭が```/example/```に一致したときだけ適用される。最長一致のパスが優先される。Webservの実装では、パスを文字列比較して判定する。  
⬜ server, locationディレクティブに設定できる  

|       | プレフィックス | 説明 |
| ---- | ---- | ---- |
| ⬜ | なし | 前方一致 |
| ⬜ | ^~ | 前方一致。一致したら、正規表現の条件を評価しない。|
| ⬜ | = | 完全一致。パスが等しい場合。|
| ⬜ | ~ | 正規表現（大文字・小文字を区別する）|
| ⬜ | ~* | 正規表現（大文字・小文字を区別しない）|

⬜ 前方一致(^~) > 正規表現 > 完全一致 > 前方一致の順に優先される。  

#### rootとalias
```
	location /s/ {
		root /var/www;
		もしくは
		alias /var/www/s;
	}
```
✅ リクエストのURIと、サーバーのディレクトリを紐付けることができる。  
⬜ aliasはlocationに、rootはhttp, server, locationディレクティブに設定できる  
⬜ aliasの場合、aliasに指定したパスにアクセスする  
⬜ rootの場合、root+locationのパス```/var/www/s```にアクセスする  
参考: [nginxのrootディレクティブとaliasディレクティブの違い](https://qiita.com/oogaki_newmedia/items/749c855ad985c8258e66)

#### index
```
	location /example/ {
		index  index.html index.php;
	}
```
✅ リクエストのURIが"/"で終わっている（ディレクトリになっている）ときに読み込まれる使われるファイル名を指定できる  
⬜ デフォルトの設定値は"index index.html;"  
<br>
<br>

## ④エラーページ
```
	error_page   500 502 503 504  /50x.html;
```
✅ 指定したエラーコードが発生したときに表示するページのURIを指定できる。  
⬜ location の中の場合、http, server, locationディレクティブに設定できる  
⬜ コードには300〜599までの数値を記述できる。  
⬜ "=レスポンスコード"を記述すると、指定したレスポンスコードを返す。  
⬜ "="だけを記述すると内部リダイレクト先のシステムから受け取ったレスポンスコードを返す。  
⬜ URIにパスだけ指定すると内部リダイレクトする（名前付きロケーションも使用可能）。  
⬜ リダイレクト先には外部のURIを指定できる。  
<br>
<br>

## ⑤リクエストボディのサイズ上限
```
	client_max_body_size 100m;
```
✅ nginxで受け付けるリクエストボディのサイズ上限を設定する  
⬜ http, server, locationディレクティブに設定できる  
⬜ デフォルト値は1MB  
⬜ 上限を超えるファイルをアップロードしようとすると、413（Request Entity Too Large）が返る  
⬜ サイズを0に設定すると、クライアントリクエストボディのサイズチェックは無効になる  
<br>
<br>

## ⑥許可 HTTP メソッド
```
	limit_except GET POST { 
		allow 192.168.1.0/24; 
		deny all; 
	} 
```
✅ この例では、GETとPOSTは誰でも利用が許可される  
⬜ locationディレクティブに設定できる  
⬜ GET メソッドの許可は、HEADメソッドも許可する  
⬜ GETとPOST以外のメソッドについては、192.168.1.0/24のローカルIPアドレスを持つ訪問者のみ許可される  
⬜ GETとPOST以外のメソッドについては、指定IPアドレス以外は拒否する  
⬜ 拒否された場合は 403 Forbiddenが返る
⬜ GET, HEAD, POST, PUT, DELETE, MKCOL, COPY, MOVE, OPTIONS, PROPFIND, PROPPATCH, LOCK, UNLOCK, PATCHに対応している  
⬜ webservでは{}内の設定は不要か?  
参考: [limit_except](https://docs.asprain.cn/NginxHTTPServer/part0143.html)
<br>
<br>

## ⑦HTTPリダイレクト
```
	server {
		listen 80;
		server_name test.com;
		return 301 https://$host$request_uri;
	}
```
✅ 処理を停止し、指定されたcodeかURLをクライアントに返す  
⬜ server,location,ifディレクティブに設定できる  
⬜ 非標準のコード 444 は応答ヘッダを送信せずに接続を閉じる  
⬜ リダイレクトURL(コード 301, 302, 303, 307 および 308)か応答ボディtext (その他のコード) のどちらかを指定することができる  

参考: [Converting rewrite rules](https://nginx.org/en/docs/http/ngx_http_rewrite_module.html#return)
<br>
<br>

## ⑧ディレクトリリスト表示
```
	location /images/ {
		autoindex on;
	}
```
✅ onの場合、スラッシュ文字で終わるリクエストが来てindexファイルが見つけられない場合、ディレクトリのリストを生成する  
⬜ http, server, locationディレクティブに設定できる   
参考: [ngx_http_autoindex_module モジュール](https://mogile.web.fc2.com/nginx/docs/http/ngx_http_autoindex_module.html)
<br>
<br>

## ⑨CGI 実行
```
	location ~ \.php$ {
		fastcgi_pass localhost:9000;
		もしくは
		fastcgi_pass unix:/run/php/php-fpm.sock;
	}
```
✅ 上記の例の場合、リクエストURIの末尾が.phpだったらfastcgi_passに設定したFastCGIサーバーへ、HTTPリクエストをFastCGIプロトコルの形式に変換して転送する  
⬜ FastCGIサーバのアドレスを設定する  
⬜ もしくはUNIXドメインソケット（名前付きパイプみたいなもの）のパスを設定する  
⬜ webservではソケットや別サーバのアドレスではなく、リクエストがあったときに実行するファイルを指定すればよい?   
⬜ 実行時に以下の環境変数を渡す必要がある  
```
	REQUEST_METHOD  
	QUERY_STRING  
	CONTENT_LENGTH  
	CONTENT_TYPE  
	SCRIPT_NAME  
	PATH_INFO 
```
⬜ リクエストがチャンク（bodyを塊に区切って連続的に送る）されていた場合はそれを解除してCGIに渡す必要がある  
⬜ CGIがContent-Lengthを返さない場合EOFまで読み込んでレスポンスとする  
⬜ CGI が相対パスを使用することがあるためスクリプトのディレクトリをカレントディレクトリとして実行する必要がある   
<br>
<br>

## ⑩ファイルアップロード場所の指定
```
	client_body_temp_path /spool/nginx/client_temp;
```
※Nginxの上記設定は、アップロードデータが保存される場所ではなく、一時ファイルが保存される場所で、保存場所自体はCGIやアプリケーションが行う。大きいPOSTデータや、メモリに収まらない場合に使われる。  
✅ クライアントからサーバーへのファイルのアップロードが許可され、保存場所が提供される   
参考: [Module ngx_http_core_module](https://nginx.org/en/docs/http/ngx_http_core_module.html#client_body_temp_path) 
<br>
<br>

## HTTPリクエストの一例
```
	GET / HTTP/1.1
	Host: example.com
	User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:11.0) Gecko/20100101 Firefox/11.0
	Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
	Accept-Language: ja,en-us;q=0.7,en;q=0.3
	Accept-Encoding: gzip, deflate
	Connection: keep-alive
```

## 参考ページ
* [nginx連載3回目: nginxの設定、その1](https://heartbeats.jp/hbblog/2012/02/nginx03.html)
* [nginx連載4回目: nginxの設定、その2 - バーチャルサーバの設定](https://heartbeats.jp/hbblog/2012/04/nginx04.html)
* [nginx連載5回目: nginxの設定、その3 - locationディレクティブ](https://heartbeats.jp/hbblog/2012/04/nginx05.html)
* [Module ngx_http_core_module](https://mogile.web.fc2.com/nginx/docs/http/ngx_http_core_module.html#limit_except)

