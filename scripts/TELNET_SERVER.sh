#!/bin/bash

TAP_NAME_L=tap3
TAP_NAME_M=tap4

# Levanto variables (direcciones de las redes, de broadcast, de los routers, máscaras, etc)
. ./ips.sh

# $1 -> ip del servidor
openvpn --config ./cliente.conf --remote $1 --port 1304 --ifconfig $IP_TEL_SERVER_L $MASC_L &

# Damos tiempo a que termine de crear la vpn
sleep 5s

# $1 -> ip del servidor
openvpn --config ./cliente.conf --remote $1 --port 1305 --ifconfig $IP_TEL_SERVER_M $MASC_M &

# Damos tiempo a que termine de crear la vpn
sleep 20s

# Tablas de ruteo
route add -net $IP_A netmask $MASC_A gw $IP_R15_L $TAP_NAME_L
route add -net $IP_B netmask $MASC_B gw $IP_R15_L $TAP_NAME_L
route add -net $IP_C netmask $MASC_C gw $IP_R15_L $TAP_NAME_L
route add -net $IP_D netmask $MASC_D gw $IP_R15_L $TAP_NAME_L
route add -net $IP_E netmask $MASC_E gw $IP_R14_L $TAP_NAME_L
route add -net $IP_F netmask $MASC_F gw $IP_R14_L $TAP_NAME_L
route add -net $IP_G netmask $MASC_G gw $IP_R14_L $TAP_NAME_L
route add -net $IP_H netmask $MASC_H gw $IP_R15_L $TAP_NAME_L
route add -net $IP_I netmask $MASC_I gw $IP_R14_L $TAP_NAME_L
route add -net $IP_J netmask $MASC_J gw $IP_R14_L $TAP_NAME_L
route add -net $IP_K netmask $MASC_K gw $IP_R14_L $TAP_NAME_L
route add -net $IP_N netmask $MASC_N gw $IP_R17_M $TAP_NAME_M
route add -net $IP_O netmask $MASC_O gw $IP_R17_M $TAP_NAME_M
route add -net $IP_P netmask $MASC_P gw $IP_R14_L $TAP_NAME_L
route add -net $IP_Q netmask $MASC_Q gw $IP_R14_L $TAP_NAME_L
route add -net $IP_R netmask $MASC_R gw $IP_R15_L $TAP_NAME_L
route add -net $IP_S netmask $MASC_S gw $IP_R14_L $TAP_NAME_L
route add -net $IP_T netmask $MASC_T gw $IP_R15_L $TAP_NAME_L
route add -net $IP_U netmask $MASC_U gw $IP_R15_L $TAP_NAME_L

# Establece el servidor DNS a consultar
echo "nameserver $IP_DNS_1" > /etc/resolv.conf

echo "Configurando Telnet Server ..."
# Arranca
	
#CONFIGURACION SERVICIO TELNET
cp ./inetd.conf /etc/inetd.conf
#/etc/init.d/inetd restart
/etc/init.d/openbsd-inetd restart

echo "OK! Telnet Server configurado."


