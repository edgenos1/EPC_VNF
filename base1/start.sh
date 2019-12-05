#!/bin/sh
date > /tngbench_share/start.txt
sysctl net.ipv6.conf.all.disable_ipv6=0
sysctl net.ipv4.conf.all.forwarding=1
export db_uri=mongodb://192.168.24.50:27017/open5gs
chmod +x setup.sh
chmod +x /dev/net/tun
/setup.sh
#iptables -t nat -A POSTROUTING -s 45.45.0.0/16 ! -o ogstun -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -I INPUT -i ogstun -j ACCEPT
sleep 10
/usr/bin/open5gs-pcrfd -D; /usr/bin/open5gs-pgwd -D; /usr/bin/open5gs-sgwd -D; /usr/bin/open5gs-hssd -D; /usr/bin/open5gs-mmed

echo "EPC VNF started"
