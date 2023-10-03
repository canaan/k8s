#/bin/sh


# change kernel parameters
sudo systemctl disable firewalld.service
sudo systemctl stop firewalld
sudo sysctl -p
sudo setenforce 0
sudo sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sudo swapoff -a
# vi /etc/fstab のswap の行をコメントアウト
# example: /dev/mapper/cl-swap swap swap defaults 0 0　
sudo lsmod | grep br_netfilter
sudo modprobe br_netfilter
sudo lsmod | grep br_netfilter
sudo sh -c 'echo "br_netfilter" > /etc/modules-load.d/br_netfilter.conf'
sudo cat < /etc/sysctl.d/k8s.conf
  net.bridge.bridge-nf-call-ip6tables = 1
  net.bridge.bridge-nf-call-iptables = 1
EOF

# installation for CRI-O as runtime
export OS=CentOS_9_Stream
export VERSION=1.27:1.27.0
sudo curl -L -o /etc/yum.repos.d/devel:kubic:libcontainers:stable.repo https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/devel:kubic:libcontainers:stable.repo
sudo curl -L -o /etc/yum.repos.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.repo https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VERSION/$OS/devel:kubic:libcontainers:stable:cri-o:$VERSION.repo
sudo yum install -y cri-o
 
# installation for Kubernetes packages
sudo cat < /etc/yum.repos.d/kubernetes.repo
  [kubernetes]
  name=Kubernetes
  baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
  enabled=1
  gpgcheck=1
  repo_gpgcheck=1
  gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl enable --now kubelet
#sudo echo "KUBELET_EXTRA_ARGS=--cgroup-driver=systemd" >> /etc/sysconfig/kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet
