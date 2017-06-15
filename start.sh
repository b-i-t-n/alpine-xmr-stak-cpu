#!/bin/sh

pool=$1
wallet=$2
password=$3
workers=$4

sed -i -e "s/POOL/${pool}/" -e "s/WALLET/${wallet}/" -e "s/PASSWORD/${password}/" /tmp/config.txt

echo '"cpu_threads_conf" :
[' >> /tmp/config.txt
COUNTER=0
while [  ${COUNTER} -lt ${workers} ]; do
  echo '{ "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : '${COUNTER}' },' >> /tmp/config.txt
  let COUNTER=COUNTER+1 
done
echo '],' >> /tmp/config.txt

/xmr-stak-cpu/bin/xmr-stak-cpu
