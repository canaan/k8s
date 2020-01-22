#!/bin/sh

# please execute this script on the external etcd-node

export CONTROL_PLANE="root@master1-ha"
scp /etc/kubernetes/pki/etcd/ca.crt "${CONTROL_PLANE}":/root/etcd-cert-files/
scp /etc/kubernetes/pki/apiserver-etcd-client.crt "${CONTROL_PLANE}":/root/etcd-cert-files/
scp /etc/kubernetes/pki/apiserver-etcd-client.key "${CONTROL_PLANE}":/root/etcd-cert-files/
