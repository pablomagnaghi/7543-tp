#!/bin/bash

#parametros a recibir por el script :: quien queres ser, y por que interfaz salir, que lo obtiene de arafue supuestamente

#mascaras genericas
MASK_24="255.255.255.0"
MASK_25="255.255.255.128"
MASK_26="255.255.255.192"
MASK_27="255.255.255.224"
MASK_28="255.255.255.240"
MASK_29="255.255.255.248"
MASK_30="255.255.255.252"

#redes que tenemos
RED_A="192.168.25.0" #/24
RED_B="10.111.25.192" #/26
RED_C="10.61.5.0" #/24
RED_D="10.111.25.128" #/27
RED_E="10.61.6.128" #/27
RED_F="10.111.25.160" #/28
RED_G="10.111.25.0" #/25
RED_H="10.61.7.128" #/25
RED_I="10.111.25.176" #/28
RED_J="10.61.6.160" #/28
RED_L="10.61.6.192" #/27

RED_M="10.61.6.176" #/30
RED_N="10.61.6.180" #/30
RED_O="10.7.5.64" #/30
RED_P="10.7.5.68" #/30
RED_Q="10.7.5.72" #/30
RED_R="10.7.5.76" #/30
RED_S="10.7.5.80" #/30
RED_T="10.7.5.84" #/30
RED_V="10.61.6.184" #/30

# IP HOST A
IP_A="10.111.25.165"
BROADCAST_A="10.111.25.175"
MASCARA_A="255.255.255.240"

# IP HOST B
IP_B="10.61.5.131"
BROADCAST_B="10.61.5.255"
MASCARA_B="255.255.255.0"

# IP HOST C
IP_C="192.168.25.8"
BROADCAST_C="192.168.25.255"
MASCARA_C="255.255.255.0"


# DIRECCION IP SERVIDOR WEB
IP_WEB="192.168.25.1"
BROADCAST_WEB="192.168.25.255"
MASCARA_WEB="255.255.255.0"

# DIRECCIONES IP SERVIDOR TELNET
IP_TELSERVER_C="10.61.5.130"
BROADCAST_TELNETC="10.61.5.255"
MASCARA_TELNETC="255.255.255.0"
IP_TELSERVER_E="10.61.6.129"
BROADCAST_TELNETE="10.61.6.159"
MASCARA_TELNETE="255.255.255.224"

# DIRECCION IP SERVIDOR FTP
IP_FTP="10.111.25.1"
BROADCAST_FTP="10.111.25.127"
MASCARA_FTP="255.255.255.128"


#DNS
IP_DNS_ROOT="192.168.25.7"
BROADCAST_DNS_ROOT="92.168.25.255"
MASCARA_DNS_ROOT="255.255.255.0"

IP_DNS_1="10.111.25.131"
BROADCAST_DNS_1="10.111.25.159"
MASCARA_DNS_1="255.255.255.224"

IP_DNS_2="10.111.25.197"
BROADCAST_DNS_2="10.111.25.255"
MASCARA_DNS_2="255.255.255.192"


#funcion de instalacion por si necesitamos ---> verificar_dependencia_e_instalar telnetd
function verificar_dependencia_e_instalar {
	paquete=$1
	INSTALADO=`dpkg -s $paquete | grep -i "Status: install ok installed" | wc -l`
	if [ "$INSTALADO" -ne "1" ]; then
		echo " * El paquete $paquete no se encuentra instalado."
		echo "Instalando paquete $paquete ..."
		apt-get install -y --force-yes $paquete
	else
		echo " * El paquete $paquete esta instalado correctamente."
	fi
}


function validate_bind9 {
	echo "Verificando que Bind9 este instalado..."
	if [ -f /etc/init.d/bind9 ]; then
		echo "Bind9 instalado!"
	else
		echo "Error: Bind9 no esta instalado!"

	fi

}


# Esta funcion chequea que este el programa apache2 instalado
# En las compus del laboratorio esta apache2 y existe  /etc/init.d/apache2
function validate_apache2 {
	echo "Verificando que apache2 este instalado..."
	if [ -f /etc/init.d/apache2 ]; then
		echo "Apache2 instalado!"
		return 1
	else
		echo "Error: Apache2 no esta instalado!"
		return 0
	fi
}

# Esta funcion chequea que este el programa vsftpd instalado
function validate_ftp {
	echo "Verificando que el server FTP este instalado..."
	if [ -f /etc/init.d/vsftpd ]; then
		echo "Server FTP instalado!"
	    return 1
	else
		echo "Error: Server FTP no esta instalado!"
		return 0
	fi
}

# Esta funcion chequea que este el programa telnetd instalado
# En las compus del laboratorio esta /usr/sbin/in.telnetd y el proceso /etc/init.d/inetd restart
function validate_telnetd {
	echo "Verificando que telnetd este instalado..."
	if [ -f /etc/init.d/openbsd-inetd ]; then
	#if [ -f /etc/init.d/inetd ]; then
		echo "telnetd instalado!"
	    return 1
    else
		echo "Error: telnetd no esta instalado!"
		return 0
    fi
}


#Configurar los hosts
function HOSTA {

	#CONFIGURACION INTERFACES
	ifconfig $interfaz $IP_A broadcast $BROADCAST_A netmask $MASCARA_A
	#RUTEO ESTATICO
	route add -net $RED_A netmask $MASK_24 gw 10.111.25.163 dev $interfaz
	route add -net $RED_B netmask $MASK_26 gw 10.111.25.164 dev $interfaz
	route add -net $RED_C netmask $MASK_24 gw 10.111.25.162 dev $interfaz
	route add -net $RED_D netmask $MASK_27 gw 10.111.25.162 dev $interfaz
	route add -net $RED_E netmask $MASK_27 gw 10.111.25.162 dev $interfaz
	route add -net $RED_G netmask $MASK_25 gw 10.111.25.163 dev $interfaz
	route add -net $RED_H netmask $MASK_25 gw 10.111.25.161 dev $interfaz
	route add -net $RED_I netmask $MASK_28 gw 10.111.25.164 dev $interfaz
	route add -net $RED_J netmask $MASK_28 gw 10.111.25.162 dev $interfaz
	route add -net $RED_L netmask $MASK_27 gw 10.111.25.164 dev $interfaz
	route add -net $RED_M netmask $MASK_30 gw 10.111.25.161 dev $interfaz
	route add -net $RED_N netmask $MASK_30 gw 10.111.25.162 dev $interfaz
	route add -net $RED_O netmask $MASK_30 gw 10.111.25.161 dev $interfaz
	route add -net $RED_P netmask $MASK_30 gw 10.111.25.161 dev $interfaz
	route add -net $RED_Q netmask $MASK_30 gw 10.111.25.161 dev $interfaz
	route add -net $RED_R netmask $MASK_30 gw 10.111.25.161 dev $interfaz
	route add -net $RED_S netmask $MASK_30 gw 10.111.25.161 dev $interfaz
	route add -net $RED_T netmask $MASK_30 gw 10.111.25.161 dev $interfaz
	route add -net $RED_V netmask $MASK_30 gw 10.111.25.164 dev $interfaz


}

function HOSTB {
	#CONFIGURACION INTERFACES
	ifconfig $interfaz $IP_B broadcast $BROADCAST_B netmask $MASCARA_B

	#RUTEO ESTATICO
	route add -net $RED_A netmask $MASK_24 gw "10.61.5.1" dev $interfaz
	route add -net $RED_B netmask $MASK_26 gw "10.61.5.1" dev $interfaz
	route add -net $RED_D netmask $MASK_27 gw "10.61.5.2" dev $interfaz
	route add -net $RED_E netmask $MASK_27 gw "10.61.5.1" dev $interfaz
	route add -net $RED_F netmask $MASK_28 gw "10.61.5.1" dev $interfaz
	route add -net $RED_G netmask $MASK_25 gw "10.61.5.1" dev $interfaz
	route add -net $RED_H netmask $MASK_25 gw "10.61.5.1" dev $interfaz
	route add -net $RED_I netmask $MASK_28 gw "10.61.5.1" dev $interfaz
	route add -net $RED_J netmask $MASK_28 gw "10.61.5.2" dev $interfaz
	route add -net $RED_L netmask $MASK_27 gw "10.61.5.1" dev $interfaz
	route add -net $RED_M netmask $MASK_30 gw "10.61.5.1" dev $interfaz
	route add -net $RED_N netmask $MASK_30 gw "10.61.5.1" dev $interfaz
	route add -net $RED_O netmask $MASK_30 gw "10.61.5.1" dev $interfaz
	route add -net $RED_P netmask $MASK_30 gw "10.61.5.1" dev $interfaz
	route add -net $RED_Q netmask $MASK_30 gw "10.61.5.1" dev $interfaz
	route add -net $RED_R netmask $MASK_30 gw "10.61.5.1" dev $interfaz
	route add -net $RED_S netmask $MASK_30 gw "10.61.5.1" dev $interfaz
	route add -net $RED_T netmask $MASK_30 gw "10.61.5.1" dev $interfaz
	route add -net $RED_V netmask $MASK_30 gw "10.61.5.1" dev $interfaz


}

function HOSTC {
	#CONFIGURACION INTERFACES
	ifconfig $interfaz $IP_C broadcast $BROADCAST_C netmask $MASCARA_C

	#RUTEO ESTATICO
	route add -net $RED_B netmask $MASK_26 gw "192.168.25.4" dev $interfaz
	route add -net $RED_C netmask $MASK_24 gw "192.168.25.2" dev $interfaz
	route add -net $RED_D netmask $MASK_27 gw "192.168.25.2" dev $interfaz
	route add -net $RED_E netmask $MASK_27 gw "192.168.25.2" dev $interfaz
	route add -net $RED_F netmask $MASK_28 gw "192.168.25.3" dev $interfaz
	route add -net $RED_G netmask $MASK_25 gw "192.168.25.3" dev $interfaz
	route add -net $RED_H netmask $MASK_25 gw "192.168.25.3" dev $interfaz
	route add -net $RED_I netmask $MASK_28 gw "192.168.25.4" dev $interfaz
	route add -net $RED_J netmask $MASK_28 gw "192.168.25.2" dev $interfaz
	route add -net $RED_L netmask $MASK_27 gw "192.168.25.4" dev $interfaz
	route add -net $RED_M netmask $MASK_30 gw "192.168.25.3" dev $interfaz
	route add -net $RED_N netmask $MASK_30 gw "192.168.25.3" dev $interfaz
	route add -net $RED_O netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_P netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_Q netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_R netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_S netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_T netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_V netmask $MASK_30 gw "192.168.25.4" dev $interfaz


}


#Configurar los servers
function WEBSERVER {

	#CONFIGURACION INTERFACES
	ifconfig $interfaz $IP_WEB broadcast $BROADCAST_WEB netmask $MASCARA_WEB 

	#RUTEO ESTATICO
	route add -net $RED_B netmask $MASK_26 gw "192.168.25.4" dev $interfaz
	route add -net $RED_C netmask $MASK_24 gw "192.168.25.2" dev $interfaz
	route add -net $RED_D netmask $MASK_27 gw "192.168.25.2" dev $interfaz
	route add -net $RED_E netmask $MASK_27 gw "192.168.25.2" dev $interfaz
	route add -net $RED_F netmask $MASK_28 gw "192.168.25.3" dev $interfaz
	route add -net $RED_G netmask $MASK_25 gw "192.168.25.3" dev $interfaz
	route add -net $RED_H netmask $MASK_25 gw "192.168.25.3" dev $interfaz
	route add -net $RED_I netmask $MASK_28 gw "192.168.25.4" dev $interfaz
	route add -net $RED_J netmask $MASK_28 gw "192.168.25.2" dev $interfaz
	route add -net $RED_L netmask $MASK_27 gw "192.168.25.4" dev $interfaz
	route add -net $RED_M netmask $MASK_30 gw "192.168.25.3" dev $interfaz
	route add -net $RED_N netmask $MASK_30 gw "192.168.25.3" dev $interfaz
	route add -net $RED_O netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_P netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_Q netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_R netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_S netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_T netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_V netmask $MASK_30 gw "192.168.25.4" dev $interfaz


	validate_apache2
	if [ $? -eq 1 ]; then
		echo "Configurando Web Server ..."
		cp -r ./servers/web/index.html /var/www/
		cp -r ./servers/web/apache2.conf /etc/apache2/	

		# Arranca el proceso de apache2
		/etc/init.d/apache2 restart
		echo "OK! Web Server configurado."
	else
		echo "No se pudo configurar el Web Server correctamente."
	fi
}

function FTPSERVER {
	#CONFIGURACION INTERFACES
	ifconfig $interfaz $IP_FTP broadcast $BROADCAST_FTP netmask $MASCARA_FTP

	#RUTEO ESTATICO
	route add -net $RED_A netmask $MASK_24 gw "10.111.25.2" dev $interfaz
	route add -net $RED_B netmask $MASK_26 gw "10.111.25.2" dev $interfaz
	route add -net $RED_C netmask $MASK_24 gw "10.111.25.2" dev $interfaz
	route add -net $RED_D netmask $MASK_27 gw "10.111.25.2" dev $interfaz
	route add -net $RED_E netmask $MASK_27 gw "10.111.25.2" dev $interfaz
	route add -net $RED_F netmask $MASK_28 gw "10.111.25.2" dev $interfaz
	route add -net $RED_H netmask $MASK_25 gw "10.111.25.2" dev $interfaz
	route add -net $RED_I netmask $MASK_28 gw "10.111.25.2" dev $interfaz
	route add -net $RED_J netmask $MASK_28 gw "10.111.25.2" dev $interfaz
	route add -net $RED_L netmask $MASK_27 gw "10.111.25.2" dev $interfaz
	route add -net $RED_M netmask $MASK_30 gw "10.111.25.2" dev $interfaz
	route add -net $RED_N netmask $MASK_30 gw "10.111.25.2" dev $interfaz
	route add -net $RED_O netmask $MASK_30 gw "10.111.25.2" dev $interfaz
	route add -net $RED_P netmask $MASK_30 gw "10.111.25.2" dev $interfaz
	route add -net $RED_Q netmask $MASK_30 gw "10.111.25.2" dev $interfaz
	route add -net $RED_R netmask $MASK_30 gw "10.111.25.2" dev $interfaz
	route add -net $RED_S netmask $MASK_30 gw "10.111.25.2" dev $interfaz
	route add -net $RED_T netmask $MASK_30 gw "10.111.25.2" dev $interfaz
	route add -net $RED_V netmask $MASK_30 gw "10.111.25.2" dev $interfaz

	validate_ftp
	if [ $? -eq 1 ]; then
		echo "Configurando FTP Server ..."
		#cp ./servers/ftp/vsftpd.conf /etc/vsftpd.conf
		/etc/init.d/vsftpd start
		echo "OK! FTP Server configurado."
	else
		echo "No se pudo configurar el FTP Server correctamente."
	fi
}

function TELSERVER {
	#Este IGNORA las interfaces que recibe por parametro
	#CONFIGURACION INTERFACES
	interfazC="tap0"
	interfazE="tap1"
	ifconfig $interfazC $IP_TELSERVER_C broadcast $BROADCAST_TELNETC netmask $MASCARA_TELNETC

	ifconfig $interfazE $IP_TELSERVER_E broadcast $BROADCAST_TELNETE netmask $MASCARA_TELNETE
	echo $interfazE
	echo $interfazC
	#RUTEO ESTATICO
	route add -net $RED_A netmask $MASK_24 gw "10.61.6.131" dev $interfazE
	route add -net $RED_B netmask $MASK_26 gw "10.61.6.131" dev $interfazE
	route add -net $RED_D netmask $MASK_27 gw "10.61.5.2" dev $interfazC
	route add -net $RED_F netmask $MASK_28 gw "10.61.6.130" dev $interfazE
	route add -net $RED_G netmask $MASK_25 gw "10.61.6.131" dev $interfazE
	route add -net $RED_H netmask $MASK_25 gw "10.61.6.131" dev $interfazE
	route add -net $RED_I netmask $MASK_28 gw "10.61.6.131" dev $interfazE
	route add -net $RED_J netmask $MASK_28 gw "10.61.5.2" dev $interfazC
	route add -net $RED_L netmask $MASK_27 gw "10.61.6.131" dev $interfazE
	route add -net $RED_M netmask $MASK_30 gw "10.61.6.131" dev $interfazE
	route add -net $RED_N netmask $MASK_30 gw "10.61.6.130" dev $interfazE
	route add -net $RED_O netmask $MASK_30 gw "10.61.6.131" dev $interfazE
	route add -net $RED_P netmask $MASK_30 gw "10.61.6.131" dev $interfazE
	route add -net $RED_Q netmask $MASK_30 gw "10.61.6.131" dev $interfazE
	route add -net $RED_R netmask $MASK_30 gw "10.61.6.131" dev $interfazE
	route add -net $RED_S netmask $MASK_30 gw "10.61.6.131" dev $interfazE
	route add -net $RED_T netmask $MASK_30 gw "10.61.6.131" dev $interfazE
	route add -net $RED_V netmask $MASK_30 gw "10.61.6.130" dev $interfazE

	
	validate_telnetd
	if [ $? -eq 1 ]; then
		echo "Configurando Telnet Server ..."
		# Arranca
	
		#CONFIGURACION SERVICIO TELNET
		#cp ./servers/telnet/inetd.conf /etc/inetd.conf
		/etc/init.d/inetd restart
		#/etc/init.d/openbsd-inetd restart
		
		echo "OK! Telnet Server configurado."
	else
		echo "No se pudo configurar el Telnet Server correctamente."
	fi
}


#Copiar las dbs, options, etc para usar los DNS, recibe el folder que queda en bind
function dns_importar_db {
  	rm --force --recursive					/etc/bind
        mkdir							/etc/bind
        cp --recursive ./dns/$1/*				/etc/bind
}

#Configurar DNS ROOT
function DNSROOT {
#poner ifconfig!

	#CONFIGURACION INTERFACES
	ifconfig $interfaz $IP_DNS_ROOT broadcast $BROADCAST_DNS_ROOT netmask $MASCARA_DNS_ROOT
	#RUTEO ESTATICO
	route add -net "192.168.25.0/24" dev $interfaz
	route add -net $RED_B netmask $MASK_26 gw "192.168.25.4" dev $interfaz
	route add -net $RED_C netmask $MASK_24 gw "192.168.25.2" dev $interfaz
	route add -net $RED_D netmask $MASK_27 gw "192.168.25.2" dev $interfaz
	route add -net $RED_E netmask $MASK_27 gw "192.168.25.2" dev $interfaz
	route add -net $RED_F netmask $MASK_28 gw "192.168.25.3" dev $interfaz
	route add -net $RED_G netmask $MASK_25 gw "192.168.25.3" dev $interfaz
	route add -net $RED_H netmask $MASK_25 gw "192.168.25.3" dev $interfaz
	route add -net $RED_I netmask $MASK_28 gw "192.168.25.4" dev $interfaz
	route add -net $RED_J netmask $MASK_28 gw "192.168.25.2" dev $interfaz
	route add -net $RED_L netmask $MASK_27 gw "192.168.25.4" dev $interfaz
	route add -net $RED_M netmask $MASK_30 gw "192.168.25.3" dev $interfaz
	route add -net $RED_N netmask $MASK_30 gw "192.168.25.3" dev $interfaz
	route add -net $RED_O netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_P netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_Q netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_R netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_S netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_T netmask $MASK_30 gw "192.168.25.2" dev $interfaz
	route add -net $RED_V netmask $MASK_30 gw "192.168.25.4" dev $interfaz

	dns_importar_db "dnsroot"

	echo "nameserver 127.0.0.1" > /etc/resolv.conf
        cp dns/bind9 /etc/default/bind9		
	/etc/init.d/bind9 restart
}

#Configurar DNS 1
function DNS1 {
	#CONFIGURACION INTERFACES
	ifconfig $interfaz $IP_DNS_1 broadcast $BROADCAST_DNS_1 netmask $MASCARA_DNS_1
	#RUTEO ESTATICO	
	route add -net "10.111.25.128/27" dev $interfaz
	route add -net $RED_A netmask $MASK_24 gw "10.111.25.129" dev $interfaz
	route add -net $RED_B netmask $MASK_26 gw "10.111.25.129" dev $interfaz
	route add -net $RED_C netmask $MASK_24 gw "10.111.25.129" dev $interfaz
	route add -net $RED_E netmask $MASK_27 gw "10.111.25.129" dev $interfaz
	route add -net $RED_F netmask $MASK_28 gw "10.111.25.129" dev $interfaz
	route add -net $RED_G netmask $MASK_25 gw "10.111.25.129" dev $interfaz
	route add -net $RED_H netmask $MASK_25 gw "10.111.25.129" dev $interfaz
	route add -net $RED_I netmask $MASK_28 gw "10.111.25.129" dev $interfaz
	route add -net $RED_J netmask $MASK_28 gw "10.111.25.130" dev $interfaz
	route add -net $RED_L netmask $MASK_27 gw "10.111.25.129" dev $interfaz
	route add -net $RED_M netmask $MASK_30 gw "10.111.25.129" dev $interfaz
	route add -net $RED_N netmask $MASK_30 gw "10.111.25.129" dev $interfaz
	route add -net $RED_O netmask $MASK_30 gw "10.111.25.129" dev $interfaz
	route add -net $RED_P netmask $MASK_30 gw "10.111.25.129" dev $interfaz
	route add -net $RED_Q netmask $MASK_30 gw "10.111.25.129" dev $interfaz
	route add -net $RED_R netmask $MASK_30 gw "10.111.25.129" dev $interfaz
	route add -net $RED_S netmask $MASK_30 gw "10.111.25.129" dev $interfaz
	route add -net $RED_T netmask $MASK_30 gw "10.111.25.129" dev $interfaz
	route add -net $RED_V netmask $MASK_30 gw "10.111.25.129" dev $interfaz

	dns_importar_db "dns1"

	echo "nameserver $IP_DNS_ROOT" > /etc/resolv.conf
        cp dns/bind9 /etc/default/bind9		
	/etc/init.d/bind9 restart
}

#Configurar DNS 2
function DNS2 {
	#CONFIGURACION INTERFACES
	ifconfig $interfaz $IP_DNS_2 broadcast $BROADCAST_DNS_2 netmask $MASCARA_DNS_2
	#RUTEO ESTATICO	
	route add -net "10.111.25.192/26" dev $interfaz
	route add -net $RED_A netmask $MASK_24 gw "10.111.25.196" dev $interfaz
	route add -net $RED_C netmask $MASK_24 gw "10.111.25.196" dev $interfaz
	route add -net $RED_D netmask $MASK_27 gw "10.111.25.196" dev $interfaz
	route add -net $RED_E netmask $MASK_27 gw "10.111.25.196" dev $interfaz
	route add -net $RED_F netmask $MASK_28 gw "10.111.25.195" dev $interfaz
	route add -net $RED_G netmask $MASK_25 gw "10.111.25.195" dev $interfaz
	route add -net $RED_H netmask $MASK_25 gw "10.111.25.195" dev $interfaz
	route add -net $RED_I netmask $MASK_28 gw "10.111.25.196" dev $interfaz
	route add -net $RED_J netmask $MASK_28 gw "10.111.25.196" dev $interfaz
	route add -net $RED_L netmask $MASK_27 gw "10.111.25.196" dev $interfaz
	route add -net $RED_M netmask $MASK_30 gw "10.111.25.196" dev $interfaz
	route add -net $RED_N netmask $MASK_30 gw "10.111.25.195" dev $interfaz
	route add -net $RED_O netmask $MASK_30 gw "10.111.25.196" dev $interfaz
	route add -net $RED_P netmask $MASK_30 gw "10.111.25.196" dev $interfaz
	route add -net $RED_Q netmask $MASK_30 gw "10.111.25.196" dev $interfaz
	route add -net $RED_R netmask $MASK_30 gw "10.111.25.196" dev $interfaz
	route add -net $RED_S netmask $MASK_30 gw "10.111.25.196" dev $interfaz
	route add -net $RED_T netmask $MASK_30 gw "10.111.25.196" dev $interfaz
	route add -net $RED_V netmask $MASK_30 gw "10.111.25.195" dev $interfaz

	dns_importar_db "dns2"

	echo "nameserver $IP_DNS_ROOT" > /etc/resolv.conf
        cp dns/bind9 /etc/default/bind9		
	/etc/init.d/bind9 restart
}

##### MAIN ######



#Deshabilitar el forward porque los hosts no redireccionan paquetes.
function no_forward {
	echo "Deshabilitando el forwarding..."
	sysctl -w net.ipv4.ip_forward=0  > /dev/null
	RESPU=$(cat /proc/sys/net/ipv4/ip_forward)
	if [ $RESPU -eq 0 ]; then
		echo "Forwarding de add -net $shabilitado."
	else
	echo "No se pudo deshabilitar el forwarding!!!."
	fi
}

function defaultDNS {
	echo "Seteando DNSs..."
	echo "nameserver $IP_DNS_ROOT" > /etc/resolv.conf
	echo "DNSs seteados."
}


if [ $# != 2 ]; then
	echo "Modo de uso :: [HOST] [interfaz]"
	exit 0
fi

interfaz=$2

if [ $1 = "HOSTA" ]; then
	echo "HOSTA"
	echo "Configurando interfaces y tablas de ruteo.."
	HOSTA
	echo "Tablas de ruteo e interfaces configuradas"
	no_forward
	defaultDNS
	exit 0
fi

if [ $1 = "HOSTB" ]; then
	echo "HOSTB"
	echo "Configurando interfaces y tablas de ruteo.."
	HOSTB
	echo "Tablas de ruteo e interfaces configuradas"
	no_forward
	defaultDNS
	exit 0
fi

if [ $1 = "HOSTC" ]; then
	echo "HOSTC"
	echo "Configurando interfaces y tablas de ruteo.."
	HOSTC
   	echo "Tablas de ruteo e interfaces configuradas"
	no_forward
	defaultDNS
	exit 0
fi

if [ $1 = "WEBSERVER" ]; then
	echo "WEBSERVER"
	echo "Configurando interfaces y tablas de ruteo.."
	WEBSERVER
   	echo "Tablas de ruteo e interfaces configuradas"
	no_forward
	defaultDNS
	exit 0
fi

if [ $1 = "FTPSERVER" ] ; then
	echo "FTPSERVER"
	echo "Configurando interfaces y tablas de ruteo.."
	FTPSERVER
   	echo "Tablas de ruteo e interfaces configuradas"
	no_forward
	defaultDNS
	exit 0
fi

if [ $1 = "TELSERVER" ]; then
	echo "TELSERVER"

	echo "Configurando interfaces y tablas de ruteo.."
	TELSERVER
   	echo "Tablas de ruteo e interfaces configuradas"
	no_forward
	defaultDNS
	exit 0
fi


if [ $1 = "DNSROOT" ]; then
	echo "DNSROOT"

	echo "Configurando el DNSROOT"
	DNSROOT
	echo "Configuracion OK!"

	no_forward

	exit 0
fi

if [ $1 = "DNS1" ]; then
	echo "DNS1"

	echo "Configurando el DNS1"
	DNS1
	echo "Configuracion OK!"

	no_forward

	exit 0
fi

if [ $1 = "DNS2" ]; then
	echo "DNS2"
	echo "Configurando el DNS2"
	DNS2
	echo "Configuracion OK!"

	no_forward

	exit 0
fi


echo "No se encontro el host " $1
exit 1
