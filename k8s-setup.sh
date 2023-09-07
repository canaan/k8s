#!/bin/sh

K8SNODE=("172.16.254.32" "172.16.254.33" "172.16.254.41" "172.16.254.42" "172.16.254.43")

for i in "${K8SNODE[@]}";
do
	echo "${i}"
done


for i in "${K8SNODE[@]}";
do
for HOST in "kubectl get node $i -o=jsonpath='{.status.addresses[1].address}'";
do
	ssh $HOST "sudo kubeadm init --pod-network-cidr=10.244.0.0/16  --upload-certs --control-plane-endpoint=172.16.254.3:6443"
	sleep 120 
	ssh $HOST "mkdir $HOME/.kube/"
	sleep 3
	ssh $HOST "sudo sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config"
	sleep 3
	ssh $HOST "sudo chown $(id -u):$(id -g) $HOME/.kube/config"
done
done
