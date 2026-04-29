<?php

// DB接続情報
define( 'DB_NAME', getenv('DB_NAME') );
define( 'DB_USER', getenv('DB_USER') );
define( 'DB_PASSWORD', trim(file_get_contents('/run/secrets/db_password')) );
define( 'DB_HOST', getenv('DB_HOST'));
define( 'DB_CHARSET', getenv('DB_CHARSET') ?: 'utf8mb4' );
define( 'DB_COLLATE', getenv('DB_COLLATE') ?: '' );

// 自動でリダイレクトするページのURLを指定する
define('WP_HOME',          getenv('WORDPRESS_URL'));
define('WP_SITEURL',       getenv('WORDPRESS_URL'));

// 複数のwordpressがひとつのDBを共有するときに名前が衝突しないようにするためにテーブル名の先頭につける値
// wordpressはこれが定義されていること前提で動いているので設定必須
$table_prefix = 'wp_';

// wordpressがルートとして用いるパス
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', '/var/www/html/');
}

// このファイル内で設定した変数等を用いて実作業を行うプログラムを呼び出す
require_once ABSPATH . 'wp-settings.php';
