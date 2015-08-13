#!/bin/sh

# Please set your environment.
 C=""
ST=""
 L=""
 O=""
OU=""
CN=""

# example
 C="JP"
ST="Fukuoka"
 L="Fukuoka"
 O="foo"
OU="bar"
CN="Consul"

# Delete roles/consul/files/etc/consul.d/ssl
rm -rf roles/consul/files/etc/consul.d/ssl

# プライベート CA 用ディレクトリ作成 
mkdir -p roles/consul/files/etc/consul.d/ssl/CA

# プライベート CA 用ディレクトリに移動
cd roles/consul/files/etc/consul.d/ssl/CA

# 証明書のシリアル番号が記録されるファイルを作成（初期値を 000a にする）
echo "000a" > serial

# 証明書のインデックスが記録されるファイルを作成
touch certindex

# 自己署名ルート証明書のリクエスト
# openssl req -x509 -newkey rsa:2048 -days 3650 -nodes -out ca.cert
openssl req \
  -x509 \
  -newkey rsa:2048 \
  -days 3650 \
  -nodes \
  -subj "/C=${C}/ST=${ST}/L=${L}/O=${O}/CN=${CN}" \
  -out ca.cert

# 自己証明書のリクエスト（CSR と秘密鍵の生成）
# openssl req -newkey rsa:1024 -nodes -out consul.csr -keyout consul.key
openssl req \
  -newkey rsa:2048 \
  -nodes \
  -subj "/C=${C}/ST=${ST}/L=${L}/O=${O}/OU=${OU}/CN=${CN}" \
  -out consul.csr \
  -keyout consul.key 

# 認証局の設定
cat << EOT >> myca.conf
[ ca ]
default_ca = myca

[ myca ]
unique_subject = no
new_certs_dir = .
certificate = ca.cert
database = certindex
private_key = privkey.pem
serial = serial
default_days = 3650
default_md = sha1
policy = myca_policy
x509_extensions = myca_extensions

[ myca_policy ]
commonName = supplied
stateOrProvinceName = supplied
countryName = supplied
emailAddress = optional
organizationName = supplied
organizationalUnitName = optional

[ myca_extensions ]
basicConstraints = CA:false
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always
keyUsage = digitalSignature,keyEncipherment
extendedKeyUsage = serverAuth,clientAuth
EOT

# 自己証明書の作成（証明書要求に署名して証明書を作成する）
openssl ca \
  -batch \
  -config myca.conf \
  -notext \
  -in consul.csr \
  -out consul.cert

# CA 証明書、証明書、秘密鍵を etc/consul.d/ssl/ 以下にコピーする
cp ca.cert consul.key consul.cert ../
