#!/bin/sh

REGISTRY=k8s-gw-stream
PORT=5000
NODE=k8s-node

mkdir certs
cd certs
sudo mkdir /etc/containers/certs.d/${REGISTRY}\:${PORT}/ 

sudo openssl req -newkey rsa:4096 -nodes -sha256 \
 -keyout /opt/registry/certs/domain.key -x509 -days 3650 \
 -out /opt/registry/certs/domain.crt \
 -addext "subjectAltName = DNS:${REGISTRY}" \
 -subj "/C=JP/ST=Kanagawa/L=Kawasaki/O=hoge/OU=tamalab/CN=${NODE}"
sudo cp /opt/registry/certs/domain.crt /etc/pki/ca-trust/source/anchors/
sudo update-ca-trust

sudo openssl s_client -connect k8s-gw-stream:5000 <<<'' | \
 sudo openssl x509 -out /etc/pki/ca-trust/source/anchors/test.crt \
 -subj "/C=JP/ST=Kanagawa/L=Kawasaki/O=hoge/OU=tamalab/CN=${NODE}"
sudo cp /etc/pki/ca-trust/source/anchors/test.crt /etc/containers/certs.d/${REGISTRY}\:${PORT}/
sudo update-ca-trust
sudo podman login k8s-gw-stream:5000 -u tamalab -p n00dles

sudo openssl req  -newkey rsa:4096 -nodes -sha256 \ 
 -keyout domain.key   -addext "subjectAltName = DNS:${REGISTRY}:${PORT} " \
 -x509 -days 3650 -out domain.crt \
 -subj "/C=JP/ST=Kanagawa/L=Kawasaki/O=hoge/OU=tamalab/CN=${NODE}"
sudo cp domain.crt /etc/containers/certs.d/${REGISTRY}\:${PORT}/ca.crt


