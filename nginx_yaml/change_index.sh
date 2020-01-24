#!/bin/sh

APPNAME=$1
kubectl get pods -l app=$APPNAME -o jsonpath='{.items[*].metadata.name}'> ./PODNAME

for PODNAME in `cat ./PODNAME` 
#for PODNAME in `kubectl get pods -l app=$APPNAME -o jsonpath='{.items[*].metadata.name}'`
do
	sleep 1
	kubectl exec -it ${PODNAME} -- sh -c "hostname > /usr/share/nginx/html/index.html"
done
