#!/bin/bash

INTERVAL="1"  # update interval in seconds

if [ -z "$1" ]; then
        echo
        echo usage: $0 [network-interface]
        echo
        echo e.g. $0 eth0
        echo
        echo shows packets-per-second
        exit
fi

IF=$1

while true
do
        #R1=`cat /sys/class/net/$1/statistics/rx_packets`
        #T1=`cat /sys/class/net/$1/statistics/tx_packets`
        R1=`ifconfig $1 | grep "RX packets" | awk '{ print $2 }' | awk -F: '{ print $2 }'`
        T1=`ifconfig $1 | grep "TX packets" | awk '{ print $2 }' | awk -F: '{ print $2 }'`
        sleep $INTERVAL
        #R2=`cat /sys/class/net/$1/statistics/rx_packets`
        #T2=`cat /sys/class/net/$1/statistics/tx_packets`
        R2=`ifconfig $1 | grep "RX packets" | awk '{ print $2 }' | awk -F: '{ print $2 }'`
        T2=`ifconfig $1 | grep "TX packets" | awk '{ print $2 }' | awk -F: '{ print $2 }'`
        TXPPS=`expr $T2 - $T1`
        RXPPS=`expr $R2 - $R1`
        echo "TX $1: $TXPPS pkts/s RX $1: $RXPPS pkts/s"
done

