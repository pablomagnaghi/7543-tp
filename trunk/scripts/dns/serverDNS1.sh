#!/bin/bash

sudo rm -r /etc/bind/*

echo "Iniciando la instalacion de DNS1..."

sudo cp ../../dns/dns1/* /etc/bind/ -r

echo "Dando permisos al directorio..."

sudo chmod 777 -R /etc/bind/

echo "Reiniciando BIND..."
sudo killall named
sudo service bind9 restart

sudo rndc flush
echo "Flush cache"

echo "Ejecucion finalizada"