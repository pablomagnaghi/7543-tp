#!/bin/bash

echo 'Elija el programa que desea instalar'

options=("Bind" "Telnet" "FTP" "Webserver" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Bind")
            sudo aptitude install bind9
            break
            ;; 
        "Telnet")
            sudo aptitude install xinetd
            break
            ;; 
         "FTP")
            sudo aptitude install vsftpd
            break
            ;; 
         "Webserver")
            sudo aptitude install apache2
            break
            ;; 
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done


