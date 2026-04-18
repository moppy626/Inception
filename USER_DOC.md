# Description for user 

## Description
This is a website development tool that uses Docker, Nginx, WordPress, and MariaDB.

## How To Use
1. Please clone this Git repository into an environment that has Docker installed.
2. Please place the file containing the database password and authentication key in the “secrets” folder directly under the git directory.
3. Run the “make” command in the directory directly under the repository. This will start each Docker container.
4. Access https://mmachida.42.fr:443. The WordPress dashboard will appear in your browser.
5. When you launch the app for the first time, a language selection screen will appear; please follow the on-screen instructions to complete the initial setup.
6. If this is your second or subsequent startup (and MariaDB has already been configured), the site menu will be displayed.
7. To stop the process, run “make clean” in the folder directly under Git. This will delete all created containers. (DB data will not be deleted, as it is stored on a local volume.)

## Info
- [【絶対やっておくべき！】WordPressの初期設定を徹底解説](https://www.conoha.jp/lets-wp/wp-setting/)