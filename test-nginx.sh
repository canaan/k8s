#!/bin/sh

# ./test-nginx.sh <iteration of cURL>
ITE=$1
USER=root
HOST=master1-ha
ssh $USER@$HOST kubectl get svc -o jsonpath='{.items[*].status.loadBalancer.ingress[0].ip}' > external_ip


echo "The iteration times are "$ITE

for i in `cat ./external_ip`
do
	echo "The external ip of LoadBalancer ingress is "$i
	for j in `seq $ITE` 
	#for j in `seq 10`
	do
		curl -s $i
	        sleep 1
	done
done



