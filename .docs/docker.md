
## Dockerの仕組み
ホストマシンのLinuxのnamecpaceやgroupsという機能を使用して、ホストOSのカーネルを共有しながらその1プロセスとして仮想環境を管理する。
- namespace
PID、ネットワーク、ユーザやグループ、ホスト名やドメイン名などのOSの環境を、1プロセス内の隔離された空間で独立して管理できるようにする機能。特に指定しなければすべてのプロセスはデフォルトの名前空間で実行される。
```ps auxf```でよくわかる。
- cgroups
"Control Group"の略。ホストOSが持つCPUやメモリなどのリソースに対して、グループごとに制限をかけられる。cgroupを使って、あるコンテナがホストOSの持つ有限なリソースを使いつくして、ホストOS上のプロセスや他のコンテナに影響を与えないようにできる。
- カーネル
コンピュータの資源（CPUやメモリ、ディスクなど）をアプリごとに安全に管理するOSの機能。これにより、複数のアプリを同じマシンで同時に動かしても互いに干渉せず、効率よくリソースを使えるようになる。


## Docker-compose
- restart: always
	OSを起動したら自動でコンテナが立ち上がるようにする設定
	デフォルトはno。on-failureはエラー終了のときだけ、unless-stoppedはOSを終了したときの状態にする

- [Dockerfile を書くベストプラクティス](https://docs.docker.jp/develop/develop-images/dockerfile_best-practices.html)


-[コンテナの仕組みとLinuxカーネルのコンテナ機能［1］名前空間とは？](https://gihyo.jp/admin/serial/01/linux_containers/0002)
- [Linuxカーネルのコンテナ機能［2］ ─cgroupとは？（その1）](linux_containers/0003)






