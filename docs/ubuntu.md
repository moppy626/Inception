# DockerのホストPCで設定すること

wget https://releases.ubuntu.com/22.04/ubuntu-22.04.5-desktop-amd64.iso
でisoをダウンロード

- /etc/hostsファイルに、```127.0.0.1 mmachida.42.fr```を追加する
- 下記でボリュームの設定先を作っておく
```
mkdir -p /home/mmachida/data/db_data
mkdir -p /home/mmachida/data/wp_data
```

### Dockerfileはなぜapt-getなのか
- ユーザーに分かりやすい丁寧なエラーメッセージを出すaptに比べて出力がシンプルで分析しやすい
- 設計の方針として安定性を重視している
- 細かな設定がしやすい
- 上記の理由からスクリプトに最適である

### なぜdocker-composeではなくdocker composeを使わなければならないのか
- docker-composeは古く、廃止予定のため

Dockerボリュームの実体の保存場所を指定する
- [Define and manage volumes in Docker Compose](https://docs.docker.com/reference/compose-file/volumes/)
