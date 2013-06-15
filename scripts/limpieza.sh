#Detiene el servicio
function stopOpenVPN {
    /etc/init.d/openvpn stop
    rm /etc/openvpn/*.conf
} 

# Permite hacer flush de la tabla de ruteo
function flushRoutes {
    # Flush de rutas
    `ip route flush all`
}
 
# Permite hacer flush de todas las interfaces ethX
# que haya en la PC.
function flushEthernet {
    ifconfig | grep "eth" > eth.tmp
     
    i=`wc -l eth.tmp | cut -d" " -f1`
    while [ $i -ne 0 ];    do
        if=`head -$i eth.tmp | tail -1 | cut -d" " -f1 `
        `ip addr flush $if`
        i=`expr $i - 1`
    done
 
    rm eth.tmp
}
 
# Permite hacer flush de todas las interfaces tapX
# que haya en la PC.
function flushTAP {
     ifconfig -a | grep "tap" > tap.tmp
  
    i=`wc -l tap.tmp | cut -d" " -f1`
    while [ $i -ne 0 ]; do
      if=`head -$i tap.tmp | tail -1 | cut -d" " -f1 `
        `ifconfig $if down`       
        echo "openvpn --rmtun --dev $if"
          `openvpn --rmtun --dev $if`
        i=`expr $i - 1`
    done
 
    rm tap.tmp
}
 
# Agrega a la tabla de ruteo el loopback
function addLoopbackRoute {
    #Agregado de loopback
    route add -net 127.0.0.0 netmask 255.0.0.0 gw 127.0.0.0
}
 

# MAIN

#Se detiene el servicio OpenVPN
echo -e "Deteniendo OpenVPN"
stopOpenVPN

#Limpieza
echo -e "Realizando Flush"
flushRoutes
flushEthernet
flushTAP

#Loopback
echo -e "Agregando loopback"
addLoopbackRoute

