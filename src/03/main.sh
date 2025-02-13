#!/bin/bash

arr_text=("\033[97m" "\033[91m" "\033[92m" "\033[94m" "\033[95m" "\033[30m")
arr_bg=("\033[107m" "\033[101m" "\033[102m" "\033[104m" "\033[105m" "\033[40m")

if [[ $1 -eq $2 || $3 -eq $4 ]]
then
    echo "Error: Background and text colors must not match. Call the command with other arguments."
else
    main_bg=${arr_bg[$1-1]} $add_bg$add_text
    main_text=${arr_text[$2-1]}
    add_bg=${arr_bg[$3-1]}
    add_text=${arr_text[$4-1]}

    printf "$main_bg$main_text"HOSTNAME="\033[0m$add_bg$add_text"%s"\033[0m\n" "$HOSTNAME"
    printf "$main_bg$main_text"TIMEZONE="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(timedatectl | awk '/Time zone/{print $3 " " $4 $5}')"
    printf "$main_bg$main_text"USER="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(whoami)"
    printf "$main_bg$main_text"OS="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(awk '/PRETTY_NAME=/{print substr($0, 13)}' /etc/os-release | tr -d '"')"
    printf "$main_bg$main_text"DATE="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(date +"%d %b %Y %H:%M:%S")"
    printf "$main_bg$main_text"UPTIME="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(uptime -p)"
    printf "$main_bg$main_text"UPTIME_SEC="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(awk '{print $1}' /proc/uptime)"
    printf "$main_bg$main_text"IP="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(ip a | awk '/inet .*[^l][^o]$/{print $2; exit}')"
    printf "$main_bg$main_text"MASK="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(ifconfig | awk '/netmask/{print $4; exit}')"
    printf "$main_bg$main_text"GATEWAY="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(ip route | awk '/default/{print $3}')"
    printf "$main_bg$main_text"RAM_TOTAL="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(free -m | awk '/Mem:/{print $2/1000}') GB"
    printf "$main_bg$main_text"RAM_USED="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(free -m | awk '/Mem:/{print $3/1000}') GB"
    printf "$main_bg$main_text"RAM_FREE="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(free -m | awk '/Mem:/{print $4/1000}') GB"
    printf "$main_bg$main_text"SPACE_ROOT="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(df / | awk '/\//{printf "%.2f\n", $2/1000}') MB"
    printf "$main_bg$main_text"SPACE_ROOT_USED="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(df / | awk '/\//{printf "%.2f\n", $3/1000}') MB"
    printf "$main_bg$main_text"SPACE_ROOT_FREE="\033[0m$add_bg$add_text"%s"\033[0m\n" "$(df / | awk '/\//{printf "%.2f\n", $4/1000}') MB"
fi