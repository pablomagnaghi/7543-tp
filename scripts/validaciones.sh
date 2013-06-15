#!/bin/bash


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


# Validaciones
#verificar_dependencia_e_instalar 
validate_bind9
validate_apache2
validate_ftp
validate_telnetd

