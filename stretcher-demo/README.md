## stretcher のデモ

### 使い方

1. git clone
2. docker build
3. コンテナ起動
4. atlas token 作って template 修正
5. playbook の適用

詳細は http://inokara.hateblo.jp/entry/2015/07/05/090440 にて。

## More...

### bundle install

[docker-api](https://rubygems.org/gems/docker-api/versions/1.21.4) 等が必要なので `bundle install` を実行する。

~~~
bundle install
~~~

### docker build

~~~
$ cd oreno-ansible/stretcher-demo/inventories
$ docker build -t foo .
~~~

### docker run

~~~
$ docker run --name=consul_01 --hostname=consul01 -t -d -p 22 -p 8000 foo
$ docker run --name=consul_02 --hostname=consul02 -t -d -p 22 -p 8000 foo
$ docker run --name=consul_03 --hostname=consul03 -t -d -p 22 -p 8000 foo
$ docker run --name=consul_deploy -t -d -p 22 -p 8000 foo
~~~

### atlas token 作って template 修正

~~~
vim oreno-ansible/stretcher-demo/roles/consul/vars/main.yml
~~~

以下の `your_infrastructure` と `your_token` を取得した token と任意の infrastructure に修正。

~~~
---
packages:
  - tar
  - wget
  - vim-enhanced
  - rsync

atlas_infrastructure: your_infrastructure
atlas_token: your_token
~~~

### Playbook の適用

~~~
ansible-playbook -i inventories/docker_inventory.rb default.yml --sudo -c paramiko
~~~
