# DockerのホストPCで設定すること

wget https://releases.ubuntu.com/22.04/ubuntu-22.04.5-desktop-amd64.iso
でisoをダウンロード

- /etc/hostsファイルに、```127.0.0.1 mmachida.42.fr```を追加する
- 下記でボリュームの設定先を作っておく
```
mkdir -p /home/mmachida/data/db_data
mkdir -p /home/mmachida/data/wp_data
```




Dockerボリュームの実体の保存場所を指定する
- [Define and manage volumes in Docker Compose](https://docs.docker.com/reference/compose-file/volumes/)
