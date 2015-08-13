## consul encryption のデモ

### 使い方

1. git clone
2. docker build
3. コンテナ起動
4. atlas token / consul keygen を実行して consul-encryption/roles/consul/vars/main.yml 修正
5. generate-certfiles.sh を環境に応じて設定して実行する
6. playbook の適用

詳細はhttp://inokara.hateblo.jp/entry/2015/08/13/083300 にて。

### generate-certfiles.sh の修正と実行

generate-certfiles.sh の以下を修正。

```sh
# Please set your environment.
 C="Japan"
ST="Fukuoka"
 L="Fukuoka"
 O="foo"
OU="bar"
CN="Consul"
```

修正したらスクリプトを実行すると roles/consul/files/etc/consul.d/ssl 以下に証明書ファイル、鍵ファイル等が作成される。

```sh
$ ./generate-certfiles.sh
```

以下のように出力される。

```sh
Generating a 2048 bit RSA private key
...............................+++
............+++
unable to write 'random state'
writing new private key to 'privkey.pem'
-----
Generating a 2048 bit RSA private key
............+++
...........................................+++
unable to write 'random state'
writing new private key to 'consul.key'
-----
Using configuration from myca.conf
Check that the request matches the signature
Signature ok
The Subject's Distinguished Name is as follows
countryName           :PRINTABLE:'JP'
stateOrProvinceName   :ASN.1 12:'Fukuoka'
localityName          :ASN.1 12:'Fukuoka'
organizationName      :ASN.1 12:'foo'
organizationalUnitName:ASN.1 12:'bar'
commonName            :ASN.1 12:'Consul'
Certificate is to be certified until Aug 10 06:15:16 2025 GMT (3650 days)

Write out database with 1 new entries
Data Base Updated
unable to write 'random state'
```

ファイルが生成されていることを確認する。

```sh
$ ls -l roles/consul/files/etc/consul.d/ssl/
合計 16
drwxrwxr-x 2 kappa kappa 4096  8月 13 15:15 CA
-rw-rw-r-- 1 kappa kappa 1257  8月 13 15:15 ca.cert
-rw-rw-r-- 1 kappa kappa 1298  8月 13 15:15 consul.cert
-rw-rw-r-- 1 kappa kappa 1704  8月 13 15:15 consul.key
```

### Playbook の適用

~~~
ansible-playbook -i inventories/docker_inventory.rb default.yml --sudo -c paramiko
~~~
