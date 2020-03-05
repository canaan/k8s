#!/bin/bash

# Please execute "source" command bacause of this script to change the enviroment variable of OAI commponets.

for OAI in enb mme hss spgwc spgwu; do
  export ${OAI}=`kubectl get pod -n oai -l app=oai-${OAI} | grep ${OAI} |awk '{print $1}'` 
#  echo `kubectl get pod -n oai -l app=oai-${OAI} | grep ${OAI} |awk '{print $1}'` > tmp
  #export ${OAI}=`cat tmp` 
done
