#!/bin/bash

#HOSTNAME
echo HOSTNAME=$HOSTNAME

#TIMEZONE
timezone=$(timedatectl | awk '/Time zone:/ {print}')
timezone=$(echo "$timezone" | awk '{print substr($0, 28)}')
echo TIMEZONE=$timezone

#USER
echo USER=$(whoami)

#OS
echo OS=$(awk '/PRETTY_NAME=/{print substr($0, 13)}' /etc/os-release)

#DATE
echo DATE=$(date +"%d %b %Y %H:%M:%S")

#UPTIME
echo UPTIME=$(uptime -p)

#UPTIME_SEC
echo UPTIME_SEC=$(awk '{print $1}' /proc/uptime)

#IP
echo IP=$(ip a | awk '/inet .*[^l][^o]$/{print $2; exit}')

#MASK
echo MASK=$(ifconfig | awk '/netmask/{print $4; exit}')

#GATEWAY
echo GATEWAY=$(ip route | awk '/default/{print $3}')

#RAM_TOTAL
echo RAM_TOTAL=$(free -m | awk '/Mem:/{print $2/1000}') GB

#RAM_USED
echo RAM_USED=$(free -m | awk '/Mem:/{print $3/1000}') GB

#RAM_FREE
echo RAM_FREE=$(free -m | awk '/Mem:/{print $4/1000}') GB

#SPACE_ROOT
echo SPACE_ROOT=$(df / | awk '/\//{printf "%.2f\n", $2/1000}') MB

#SPACE_ROOT_USED
echo SPACE_ROOT_USED=$(df / | awk '/\//{printf "%.2f\n", $3/1000}') MB

#SPACE_ROOT_FREE
echo SPACE_ROOT_FREE=$(df / | awk '/\//{printf "%.2f\n", $4/1000}') MB