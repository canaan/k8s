#!/bin/sh

#K8SNODE=("172.16.254.12" "172.16.254.13")
K8SWORKER=("172.16.254.21" "172.16.254.22" "172.16.254.23" "172.16.254.24" "172.16.254.25")

for i in "${K8SWORKER[@]}";
do
	echo "${i}"
done


for i in "${K8SWORKER[@]}";
do
	ssh $i sudo kubeadm join 172.16.254.2:6443 --token ql6v5t.putyqo9rawqm5exc \
	--discovery-token-ca-cert-hash sha256:2c6378f365e071710b080eca0d489cdc61513a3e7fd424ed42724713e85eae4c
done
