#!/bin/sh

apply() {
kubectl apply -f /root/metallb/metallb.yaml
kubectl apply -f /root/metallb/metallb-bgp.yaml
kubectl apply -f /root/nginx-ingress-controller/ingress-nginx/deploy/static/mandatory.yaml
kubectl apply -f /root/nginx-ingress-controller/ingress-nginx/deploy/static/provider/cloud-generic.yaml
}

delete() {
kubectl delete -f /root/nginx-ingress-controller/ingress-nginx/deploy/static/provider/cloud-generic.yaml
kubectl delete -f /root/nginx-ingress-controller/ingress-nginx/deploy/static/mandatory.yaml
kubectl delete -f /root/metallb/metallb-bgp.yaml
kubectl delete -f /root/metallb/metallb.yaml
}

case "$1" in
apply)
	set -x
	apply
	;;
delete)
	set -x
	delete
	;;
*)
	echo "usage:30 {apply|delete}"
esac
