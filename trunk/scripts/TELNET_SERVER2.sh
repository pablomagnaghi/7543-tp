#!/bin/bash

TAP_NAME_L=tap3
TAP_NAME_M=tap4

# Levanto variables (direcciones de las redes, de broadcast, de los routers, máscaras, etc)
. ./ips.sh

# $1 -> ip del servidor
openvpn --config ./conf/TEL_SERVER_L.conf --remote $1 --port 1304 --ifconfig $IP_TEL_SERVER_L $MASC_L &

# Damos tiempo a que termine de crear la vpn
sleep 5s

# $1 -> ip del servidor
openvpn --config ./conf/TEL_SERVER_M.conf --remote $1 --port 1305 --ifconfig $IP_TEL_SERVER_M $MASC_M &

# Damos tiempo a que termine de crear la vpn
sleep 20s

echo 2 tablel >> /etc/iproute2/rt_tables
echo 3 tablem >> /etc/iproute2/rt_tables

# Tablas de ruteo
ip route add "192.168.25.0/24" via $IP_R15_L table tablel
ip route add "10.61.6.160/28"  via  $IP_R15_L table tablel
ip route add "10.61.7.128/26"  via  $IP_R15_L table tablel
ip route add "10.61.7.192/27"  via  $IP_R15_L table tablel
ip route add "10.61.6.208/30"  via  $IP_R14_L  table tablel
ip route add "10.111.25.128/25"  via  $IP_R14_L  table tablel
ip route add "10.111.25.0/25"  via  $IP_R14_L  table tablel
ip route add "157.63.5.0/30"  via  $IP_R15_L  table tablel
ip route add "157.63.5.4/30"  via  $IP_R14_L  table tablel
ip route add "10.71.6.176/28" via  $IP_R14_L  table tablel
ip route add "10.61.6.212/30" via  $IP_R14_L  table tablel
ip route add "10.61.7.224/27" via  $IP_R16_L  table tablel
ip route add "10.61.6.192/28" via  $IP_R16_L  table tablel
ip route add "10.7.5.64/30"  via  $IP_R14_L  table tablel
ip route add "10.7.5.68/30"  via  $IP_R14_L  table tablel
ip route add "10.7.5.72/30"  via  $IP_R15_L  table tablel
ip route add "10.7.5.76/30"  via  $IP_R14_L  table tablel
ip route add "10.7.5.80/30"  via  $IP_R15_L  table tablel
ip route add "10.7.5.84/30"  via  $IP_R15_L  table tablel
ip route add "10.61.6.128/27" dev $TAP_NAME_L table tablel

ip route add "192.168.25.0/24" via $IP_R16_M table tablem
ip route add "10.61.6.160/28"  via  $IP_R16_M table tablem
ip route add "10.61.7.128/26"  via  $IP_R16_M table tablem
ip route add "10.61.7.192/27"  via  $IP_R16_M table tablem
ip route add "10.61.6.208/30"  via  $IP_R16_M  table tablem
ip route add "10.111.25.128/25"  via  $IP_R16_M  table tablem
ip route add "10.111.25.0/25"  via  $IP_R16_M  table tablem
ip route add "157.63.5.0/30"  via  $IP_R16_M  table tablem
ip route add "157.63.5.4/30"  via  $IP_R16_M  table tablem
ip route add "10.71.6.176/28" via  $IP_R16_M  table tablem
ip route add "10.61.6.212/30" via  $IP_R16_M  table tablem
ip route add "10.61.7.224/27" via  $IP_R17_M  table tablem
ip route add "10.61.6.192/28" via  $IP_R17_M  table tablem
ip route add "10.7.5.64/30"  via  $IP_R16_M  table tablem
ip route add "10.7.5.68/30"  via  $IP_R16_M  table tablem
ip route add "10.7.5.72/30"  via  $IP_R16_M  table tablem
ip route add "10.7.5.76/30"  via  $IP_R16_M  table tablem
ip route add "10.7.5.80/30"  via  $IP_R16_M  table tablem
ip route add "10.7.5.84/30"  via  $IP_R16_M  table tablem
ip route add "10.61.6.128/27" via $IP_R16_M table tablem
ip route add "10.61.5.0/24" dev $TAP_NAME_M table tablem

#TAP_NAME_L=tap3
#TAP_NAME_M=tap4


ip rule flush

# Agrego las reglas de fabrica
ip rule add table main prio 32766
ip rule add table default prio 32767


# Agrego las reglas del telnet
ip rule add from "10.61.5.130" lookup tablem prio 1001
ip rule add to "10.61.5.130" lookup tablem prio 1002
ip rule add from "10.61.6.129" lookup tablel prio 1003
ip rule add to "10.61.6.129" lookup tablel prio 1004

ip rule add table tablel prio 1101
ip rule add table tablem prio 1102

# Establece el servidor DNS a consultar
echo "nameserver $IP_DNS_1" > /etc/resolv.conf

echo "Configurando Telnet Server ..."
# Arranca
	
#CONFIGURACION SERVICIO TELNET
#cp inetd.conf /etc/inetd.conf
#service xinetd restart


echo "OK! Telnet Server configurado."


