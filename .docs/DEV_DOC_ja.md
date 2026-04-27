# 開発者向け説明

## 構成
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
このドキュメントは、プロジェクトについての説明が書かれています。
- Makefile
Docker Compose の起動または停止  
- secrets  
このファイルには、データベースのパスワードとワードプレスのパスワードが含まれています。Gitリポジトリには含まれていないため、別途設定してください。  
- docker-compose.yml  
各フォルダにあるDockerfileを使用してMariaDB、Nginx、WordPressのコンテナを作成し、ネットワーク経由で接続し、ボリュームを設定して起動します。  
- mariadb  
MariaDBをインストールし、my.confファイルをフォルダ内に配置します。init_mariadb.sh を実行して mysqld を起動します。初回起動時のみ、WordPress 用のデータベースを作成し、ユーザーを作成し、デフォルトの admin ユーザーのユーザー名とパスワードを変更します。
- nginx  
Nginx と OpenSSL をインストールし、SSH キーを生成します。サーバー設定を含む nginx.conf ファイルを配置し、Nginx を起動します。
- wordpress  
PHP-FPM、WordPress、および php-mysqli をインストールします。データベースへのアクセス情報を含む wp-config.php ファイルと、WordPress の設定情報を含む www.conf ファイルを、それぞれの適切なディレクトリに配置します。


## 前提条件
- 実行環境にはDockerがインストールされている必要があります
- 64bitCPU
- 8GB以上のRAM
- ストレージ4GB以上

## セットアップ方法
1. この Git リポジトリを、Docker がインストールされている環境にクローンしてください。
2. データベースのパスワードが記載されたファイルを、git ディレクトリ直下の「secrets」フォルダに入れてください。
または、```make pass``` を実行して、新しいランダムなパスワードを生成してください。
3. リポジトリ直下のディレクトリで「make」コマンドを実行してください。これにより、各Dockerコンテナが起動します。
4. https://mmachida.42.fr:443 にアクセスしてください。ブラウザにWordPressのダッシュボードが表示されます。掲示板に投稿を行ってみてください。
5. 管理者ページには https://mmachida.42.fr:443/wp-admin/ でアクセスすることができます。 
6. プロセスを停止するには、Git の直下のフォルダで「make down」を実行してください。これにより、作成されたすべてのコンテナが削除されます。
7. コンテナを再起動したり、ホストPCをシャットダウンしても作成したデータが残ることを確認してみてください。

## Makefile
- make prepare ...実行環境に必要なフォルダを作成し権限を設定します
- make pass...コンテナで使用するDBやWordpressのパスワードを自動生成します
- make up...```docker compose up```を実行します。mariadb、wordpress、nginxのDockerコンテナをそれぞれ起動します
- make stop...```docker compose stop```を実行し、それぞれのコンテナを停止します。
- make down...```docker compose down```を実行します。それぞれのコンテナを停止し削除します
- make build...```docker compose build```を実行します。キャッシュを使用せずにビルドを行うので、ファイルを変更したのに反映されない場合にご利用ください
- make mariadb, wordpress, nginx...```docker compose exec bash```を実行します。コンテナ内でコマンドを実行することができます
- make clean...データベースの内容を含むすべてのデータをクリアします
- make test...https://mmachida.42.frに対してcurlコマンドを送ることができます

## データの永続化  
これはホスト上の保存場所を指定して Docker ボリュームとして作成されるため、バインドマウントと同様にデータを保存できます。
データは `/home/mmachida/data/` 配下に保存されます。
ボリュームの内容を初期化したい場合は、`srcs` ディレクトリで `docker-compose down -v` を実行してください。これによりデータが初期化されます。

## 情報  
- [WordPressのデータベースの中身はどうなっているのか？](https://wpmake.jp/contents/security/database/)

