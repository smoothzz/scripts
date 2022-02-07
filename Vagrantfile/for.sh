#!/bin/bash

linuxIps=("192.168.0.200" "192.168.0.210" "192.168.0.220")

windowsIps=(
    "192.168.0.230"
    "192.168.0.240"
)

linuxMachines()
{
    for i in "${linuxIps[@]}"; do timeout 4 ssh vagrant@$i "hostname" ; done
}


windowsMachines()
{
    for i in "${windowsMachines[@]}"; do ssh vagrant@$i "hostname"; done
}

linuxMachines
windowsMachines
