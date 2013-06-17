#!/bin/bash
PS3='Por favor seleccione: '

options=("DNS 1" "DNS 2" "DNS Root" "Host A" "Host B" "Host C" "FTP Server" "TELNET Server" "Web server" "Quit")

if [ $1 ]; then
select opt in "${options[@]}"
do
    case $opt in
        "DNS 1")
            sudo ./DNS_1.sh $1
            break
            ;;
        "DNS 2")
            sudo ./DNS_2.sh $1
            break
            ;;
        "DNS Root")
            sudo ./DNS_ROOT.sh $1
            break
            ;;
        "Host A")
            sudo ./Host_A.sh $1
            break
            ;;
        "Host B")
            sudo ./Host_B.sh $1
            break
            ;;
        "Host C")
            sudo ./Host_C.sh $1
            break
            ;;
        "FTP Server")
            sudo ./FTP_SERVER.sh $1
            break
            ;;
        "TELNET Server")
            sudo ./TELNET_SERVER.sh $1
            break
            ;;
        "Web server")
            sudo ./WEB_SERVER.sh $1
            break
            ;;    
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
else
	echo "Uso $0 ip_server"
fi

