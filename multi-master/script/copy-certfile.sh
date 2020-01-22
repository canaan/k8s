#!/bin/sh

# Please execute this script  on other master-nodes

rm -fr /root/.kube/

USER=root
mkdir -p /etc/kubernetes/pki/etcd
cp  /${USER}/ca.crt /etc/kubernetes/pki/
cp  /${USER}/ca.key /etc/kubernetes/pki/
cp  /${USER}/sa.pub /etc/kubernetes/pki/
cp  /${USER}/sa.key /etc/kubernetes/pki/
cp  /${USER}/front-proxy-ca.crt /etc/kubernetes/pki/
cp  /${USER}/front-proxy-ca.key /etc/kubernetes/pki/
cp  /${USER}/apiserver-etcd-client.crt /etc/kubernetes/pki/
cp  /${USER}/apiserver-etcd-client.key /etc/kubernetes/pki/
cp  /${USER}/etcd-ca.crt /etc/kubernetes/pki/etcd/ca.crt
cp  /${USER}/etcd-ca.key /etc/kubernetes/pki/etcd/ca.key
cp  /${USER}/admin.conf /etc/kubernetes/admin.conf
