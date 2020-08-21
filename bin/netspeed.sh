#!/bin/bash

INTERVAL="1"  # update interval in seconds

if [ -z "$1" ]; then
        echo
        echo usage: $0 [network-interface]
        echo
        echo e.g. $0 eth0
        echo
        exit
fi

IF=$1

while true
do
        #R1=`cat /sys/class/net/$1/statistics/rx_bytes`
        #T1=`cat /sys/class/net/$1/statistics/tx_bytes`
        R1=`ifconfig $1 | grep bytes | awk '{print $2}' | awk -F: '{print $2}'`
        T1=`ifconfig $1 | grep bytes | awk '{print $6}' | awk -F: '{print $2}'`
        sleep $INTERVAL
        #R2=`cat /sys/class/net/$1/statistics/rx_bytes`
        #T2=`cat /sys/class/net/$1/statistics/tx_bytes`
        R2=`ifconfig $1 | grep bytes | awk '{print $2}' | awk -F: '{print $2}'`
        T2=`ifconfig $1 | grep bytes | awk '{print $6}' | awk -F: '{print $2}'`
        TBPS=`expr $T2 - $T1`
        RBPS=`expr $R2 - $R1`
        TKBPS=`expr $TBPS / 1024`
        RKBPS=`expr $RBPS / 1024`
        #echo "TX $1: $TKBPS kb/s RX $1: $RKBPS kb/s"
        echo "TX $1: $TKBPS kB/s RX $1: $RKBPS kB/s"
done

