#!/bin.sh

rm -fr /root/.kube
mkdir -p /etc/kubernetes/pki/etcd
cp /root/etcd-cert-files/ca.crt /etc/kubernetes/pki/etcd/
#cp /root/etcd-cert-files/ca.key /etc/kubernetes/pki/etcd/
cp /root/etcd-cert-files/apiserver-etcd-client.* /etc/kubernetes/pki/

