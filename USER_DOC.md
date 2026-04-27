# Description for user 

## Description
This is a website development tool that uses Docker, Nginx, WordPress, and MariaDB.

## How to start and stop
- Run the ‘make’ command in the directory directly under the repository. This will start each Docker container.
- To stop the process, run ‘make down’ in the folder directly under Git. This will remove all created containers.

## Available Pages
- Visit https://mmachida.42.fr:443. The WordPress dashboard will appear in your browser.
    - Edit Profile... You can edit your password, email address, nickname, etc.
    - Post Articles... You can post and edit articles only if you have the necessary permissions
    - Upload Media... You can upload media only if you have the necessary permissions
    - View Comments

- You can access the admin pages at https://mmachida.42.fr:443/wp-admin/. 
    - Dashboard... You can check for new updates
    - Updates... You can check for and manage updates for WordPress core, themes, plugins, etc.
    - Posts... You can create, edit and publish posts
    - Media... You can manage files such as images
    - Comments... You can manage comments
    - Appearance... You can install and edit design templates
    - Plugins... You can manage extensions
    - Tools... You can import and export various data

## Credentials
Please refer to the ‘secrets’ folder for the login password
The ‘credentials.txt’ file contains the passwords for WordPress users
- WP_ADMIN_PASS... WordPress administrator
- WP_PASS... WordPress user with write permissions

## Info
- [【絶対やっておくべき！】WordPressの初期設定を徹底解説](https://www.conoha.jp/lets-wp/wp-setting/)