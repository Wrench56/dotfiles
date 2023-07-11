#!/bin/sh

# Configure .conkyrc

# Jobs:
# - Set network interface
# - Set correct number of CPU cores

sudo pacman -S --noconfirm --needed networkmanager

NETIF=$(nmcli | grep -P -o "wlp.*)?=: connected)")
CPUS=$(cat /proc/cpuinfo | grep -P -o -m1 "(?<=(siblings\t: )).*")

# Set network interface
sed -i "s/@NETIF/${NETIF}/g" ~/.conkyrc

# Set CPU cores
for i in $(eval echo "{1..$VAR}")
do
    REAL_NUM=$(($i - 1))
    sed -i "s/@CPU_CORES/\${color1}\${goto 35}Core ${i}: \${color}\${freq_g ${i}}GHz \${alignr}\${cpu cpu${REAL_NUM}}% \${cpubar cpu${REAL_NUM} 4, 100}\n@CPU_CORES/" ~/.conkyrc
done

sed -i "s/@CPU_CORES//" ~/.conkyrc
