#!/bin/sh

USER=root
HOST=master1-ha
ssh $USER@$HOST kubectl get svc -o jsonpath='{.items[*].status.loadBalancer.ingress[0].ip}' > external_ip

#echo "The test of the reachability by cURL"
#echo "The number of external ip is "$#

for i in `cat ./external_ip`
do
	echo "The external ip for LoadBalancer ip is "$i
	for j in `seq 10`
	do
		curl -s $i
	        sleep 1
	done
done


#for i in $*
#do
#	echo "The external ip is "$i
#	for j in `seq 10`
#	do
#		curl -s $i
#		sleep 1
#	done
#done

