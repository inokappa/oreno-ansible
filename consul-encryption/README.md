## consul encryption のデモ

### 使い方

1. git clone
2. docker build
3. コンテナ起動
4. atlas token / consul keygen を実行して consul-encryption/roles/consul/vars/main.yml 修正
5. Private CA / 証明書と鍵を作成して consul-encryption/roles/consul/files/etc/consul.d/ssl/ 以下に設置
6. playbook の適用

詳細はhttp://inokara.hateblo.jp/entry/2015/08/13/083300 にて。

### Playbook の適用

~~~
ansible-playbook -i inventories/docker_inventory.rb default.yml --sudo -c paramiko
~~~
