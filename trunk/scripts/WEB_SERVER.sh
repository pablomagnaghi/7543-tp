#!/bin/bash

TAP_NAME=tap6

# Levanto variables (direcciones de las redes, de broadcast, de los routers, máscaras, etc)
. ./ips.sh

# $1 -> ip del servidor
openvpn --config ./cliente.conf --remote $1 --port 1307 --ifconfig $IP_WEB_SERVER $MASC_A &

# Damos tiempo a que termine de crear la vpn
sleep 10s

# Tablas de ruteo
route add -net $IP_B netmask $MASC_B gw $IP_R3_A $TAP_NAME
route add -net $IP_C netmask $MASC_C gw $IP_R3_A $TAP_NAME
route add -net $IP_D netmask $MASC_D gw $IP_R4_A $TAP_NAME
route add -net $IP_E netmask $MASC_E gw $IP_R2_A $TAP_NAME
route add -net $IP_F netmask $MASC_F gw $IP_R2_A $TAP_NAME
route add -net $IP_G netmask $MASC_G gw $IP_R2_A $TAP_NAME
route add -net $IP_H netmask $MASC_H gw $IP_R4_A $TAP_NAME
route add -net $IP_I netmask $MASC_I gw $IP_R2_A $TAP_NAME
route add -net $IP_J netmask $MASC_J gw $IP_R2_A $TAP_NAME
route add -net $IP_K netmask $MASC_K gw $IP_R2_A $TAP_NAME
route add -net $IP_L netmask $MASC_L gw $IP_R1_A $TAP_NAME
route add -net $IP_M netmask $MASC_M gw $IP_R1_A $TAP_NAME
route add -net $IP_N netmask $MASC_N gw $IP_R1_A $TAP_NAME
route add -net $IP_O netmask $MASC_O gw $IP_R1_A $TAP_NAME
route add -net $IP_P netmask $MASC_P gw $IP_R1_A $TAP_NAME
route add -net $IP_Q netmask $MASC_Q gw $IP_R1_A $TAP_NAME
route add -net $IP_R netmask $MASC_R gw $IP_R1_A $TAP_NAME
route add -net $IP_S netmask $MASC_S gw $IP_R2_A $TAP_NAME
route add -net $IP_T netmask $MASC_T gw $IP_R2_A $TAP_NAME
route add -net $IP_U netmask $MASC_U gw $IP_R2_A $TAP_NAME

# Establece el servidor DNS a consultar
echo "nameserver $IP_DNS_2" > /etc/resolv.conf

# Levantar servicio
echo "Configurando Web Server ..."
cp -r ./index.html /var/www/
cp -r ./apache2.conf /etc/apache2/	

# Arranca el proceso de apache2
/etc/init.d/apache2 restart
echo "OK! Web Server configurado."

