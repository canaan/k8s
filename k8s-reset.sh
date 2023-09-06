#!/bin/sh

K8SNODE=("172.16.254.12" "172.16.254.13" "172.16.254.21" "172.16.254.22" "172.16.254.23")
#K8SNODE=("172.16.254.11")

for i in "${K8SNODE[@]}";
do
	echo "${i}"
done


for i in "${K8SNODE[@]}";
do
 ssh $i "sudo kubeadm reset -f && sudo rm -f $HOME/.kube/config && sudo iptables -F && sudo reboot"
done
