#!/bin/sh

MASTER="master1-ha master2-ha master3-ha"
WORKER="worker1-ha worker2-ha worker3-ha worker4-ha"

flannel() {
for host in ${MASTER}; do
        kubectl drain $host  --delete-local-data --force --ignore-daemonsets
        kubectl delete node $host
	ssh $host kubeadm reset -f
	ssh $host systemctl restart docker 
	ssh $host systemctl restart kubelet 
        ssh $host iptables -t nat --flush
        ssh $host ip link delete flannel.1
        ssh $host ip link delete cni0
done

for host in ${WORKER}; do
        kubectl drain $host  --delete-local-data --force --ignore-daemonsets
        kubectl delete node $host
        ssh $host kubeadm reset -f
        ssh $host systemctl restart docker
        ssh $host systemctl restart kubelet
        ssh $host iptables -t nat --flush
        ssh $host ip link delete flannel.1
        ssh $host ip link delete cni0
done
}

calico() {
for host in ${MASTER}; do
        kubectl drain $host  --delete-local-data --force --ignore-daemonsets
        kubectl delete node $host
        ssh $host kubeadm reset -f
        ssh $host systemctl restart docker
        ssh $host systemctl restart kubelet
        ssh $host iptables -t nat --flush
        ssh $host modprobe -r ipip 
done

for host in ${WORKER}; do
        kubectl drain $host  --delete-local-data --force --ignore-daemonsets
        kubectl delete node $host
        ssh $host kubeadm reset -f
        ssh $host systemctl restart docker
        ssh $host systemctl restart kubelet
        ssh $host iptables -t nat --flush
        ssh $host modprobe -r ipip
        ssh $host systemctl restart docker
done
}

case "$1" in
flannel)
        set -x
        flannel 
        ;;
calico)
        set -x
        calico 
        ;;
*)
        echo "usage:30 {flannel|calico}"
esac
