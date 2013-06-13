#!/bin/bash

sudo rm -r /etc/bind/*

echo "Iniciando la instalacion de DNS root..."

sudo cp ../../dns/dnsroot/* /etc/bind/ -r

echo "Dando permisos al directorio..."

sudo chmod 777 -R /etc/bind/

echo "Reiniciando BIND..."
sudo killall named
sudo service bind9 restart

echo "Ejecucion finalizada"
