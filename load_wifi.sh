#!/bin/sh

insmod 8812au.ko
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
/etc/init.d/net.wlan0 start
busybox udhcpd
hostapd -dd /etc/hostapd/hostapd.conf
