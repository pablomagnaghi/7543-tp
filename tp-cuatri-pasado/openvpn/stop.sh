#!/bin/bash

####################################
# Tear Down Ethernet bridge on Linux
####################################

# Define Bridge Interface
br="br0"

# Define list of TAP interfaces to be bridged together
tap="tap0 tap1 tap2"

ifconfig $br down
brctl delbr $br

for t in $tap; do
    openvpn --rmtun --dev $t
done
