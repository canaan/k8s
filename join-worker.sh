#!/bin/sh

#K8SNODE=("172.16.254.12" "172.16.254.13")
K8SWORKER=("172.16.254.21" "172.16.254.22" "172.16.254.23" "172.16.254.24" "172.16.254.25")

TOKEN=
SHA256=
CERT_KEY=

for i in "${K8SWORKER[@]}";
do
	echo "${i}"
done


for i in "${K8SWORKER[@]}";
do
	ssh $i sudo kubeadm join 172.16.254.2:6443 --token ${TOKEN} \
	--discovery-token-ca-cert-hash sha256:${SHA256}
done
