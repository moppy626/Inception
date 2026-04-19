<?php

// DB接続情報
define( 'DB_NAME', getenv('DB_NAME') );
define( 'DB_USER', getenv('DB_USER') );
define( 'DB_PASSWORD', getenv('DB_PASSWORD') );
define( 'DB_HOST', getenv('DB_HOST') );
define( 'DB_CHARSET', getenv('DB_CHARSET') ?: 'utf8mb4' );
define( 'DB_COLLATE', getenv('DB_COLLATE') ?: '' );

// https://api.wordpress.org/secret-key/1.1/salt/で発行した認証用ユニークキー
// ここから生成した値をユーザーのcookieに入れて再ログインの時に送ってもらうことで、
// ユーザー情報が偽装されていないことを証明することができる
define('AUTH_KEY',         getenv('AUTH_KEY'));
define('SECURE_AUTH_KEY',  getenv('SECURE_AUTH_KEY'));
define('LOGGED_IN_KEY',    getenv('LOGGED_IN_KEY'));
define('NONCE_KEY',        getenv('NONCE_KEY'));
define('AUTH_SALT',        getenv('AUTH_SALT'));
define('SECURE_AUTH_SALT', getenv('SECURE_AUTH_SALT'));
define('LOGGED_IN_SALT',   getenv('LOGGED_IN_SALT'));
define('NONCE_SALT',       getenv('NONCE_SALT'));

// 複数のwordpressがひとつのDBを共有するときに名前が衝突しないようにするためにテーブル名の先頭につける値
// wordpressはこれが定義されていること前提で動いているので設定必須
$table_prefix = 'wp_';

// wordpressがルートとして用いるパス
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', '/var/www/html/');
}

// このファイル内で設定した変数等を用いて実作業を行うプログラムを呼び出す
require_once ABSPATH . 'wp-settings.php';
