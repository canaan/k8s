#!/bin/sh

K8SNODE=("172.16.254.12" "172.16.254.13" "172.16.254.21" "172.16.254.22" "172.16.254.23")
#K8SNODE=("172.16.254.11")

for i in "${K8SNODE[@]}";
do
	echo "${i}"
done


for i in "${K8SNODE[@]}";
do
# ssh $i "sudo kubeadm reset -f && sudo rm -f $HOME/.kube/config && sudo iptables -F && sudo reboot"
 ssh $i "sudo kubeadm reset --force && \
         sudo systemctl stop kubelet && \
         sudo rm -rf /etc/kubernetes/ && \
         sudo rm -rf ~/.kube/ && \
         sudo rm -rf /var/lib/kubelet/ && \
         sudo rm -rf /var/lib/cni/ && \
         sudo rm -rf /etc/cni/ && \
         sudo rm -rf /var/lib/etcd/ && \
         sudo iptables -F && sudo iptables -X && \
         sudo reboot"
done
