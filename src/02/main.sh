#!/bin/bash

output=$( cat << EOF
HOSTNAME=$HOSTNAME
TIMEZONE=$(timedatectl | awk '/Time zone/{print $3 " " $4 $5}')
USER=$(whoami)
OS=$(awk '/PRETTY_NAME=/{print substr($0, 13)}' /etc/os-release | tr -d '"')
DATE=$(date +"%d %b %Y %H:%M:%S")
UPTIME=$(uptime -p)
UPTIME_SEC=$(awk '{print $1}' /proc/uptime)
IP=$(ip a | awk '/inet .*[^l][^o]$/{print $2; exit}')
MASK=$(ifconfig | awk '/netmask/{print $4; exit}')
GATEWAY=$(ip route | awk '/default/{print $3}')
RAM_TOTAL=$(free -m | awk '/Mem:/{print $2/1000}') GB
RAM_USED=$(free -m | awk '/Mem:/{print $3/1000}') GB
RAM_FREE=$(free -m | awk '/Mem:/{print $4/1000}') GB
SPACE_ROOT=$(df / | awk '/\//{printf "%.2f\n", $2/1000}') MB
SPACE_ROOT_USED=$(df / | awk '/\//{printf "%.2f\n", $3/1000}') MB
SPACE_ROOT_FREE=$(df / | awk '/\//{printf "%.2f\n", $4/1000}') MB
EOF
)
printf "%s\n" "$output"

printf "\nDo you want to write data to a file?[Y/N]: "
read ans

if [[ $ans = Y || $ans = y ]]
then
    file_name=$(date +"%d_%m_%y_%H_%M_%S").status
    touch $file_name
    printf "%s\n" "$output" > $file_name
fi