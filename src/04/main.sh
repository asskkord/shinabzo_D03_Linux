#!/bin/bash

arr_text=("\033[97m" "\033[91m" "\033[92m" "\033[94m" "\033[95m" "\033[30m")
arr_bg=("\033[107m" "\033[101m" "\033[102m" "\033[104m" "\033[105m" "\033[40m")
match_arr=("white" "red" "green" "blue" "purple" "black")

col1bg=$(awk -F'=' '/column1_background=/ {print $2}' colors.cfg)-1
col1ft=$(awk -F'=' '/column1_font_color=/ {print $2}' colors.cfg)-1
col2bg=$(awk -F'=' '/column2_background=/ {print $2}' colors.cfg)-1
col2ft=$(awk -F'=' '/column2_font_color=/ {print $2}' colors.cfg)-1

iscol1bg=0; iscol1ft=0; iscol2bg=0; iscol2ft=0;

if [[ $col1bg -eq -1 ]]; then col1bg=0; iscol1bg=1; fi
if [[ $col1ft -eq -1 ]]; then col1ft=5; iscol1ft=1; fi
if [[ $col2bg -eq -1 ]]; then col2bg=0; iscol2bg=1; fi
if [[ $col2ft -eq -1 ]]; then col2ft=5; iscol2ft=1; fi

if [[ $col1bg -eq $col1ft || $col2bg -eq $col2ft ]]
then
    echo "Error: Background and text colors must not match. Call the command with other arguments."
else
    main_bg=${arr_bg[$col1bg]}
    main_text=${arr_text[$col1ft]}
    add_bg=${arr_bg[$col2bg]}
    add_text=${arr_text[$col2ft]}

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

    if [[ $iscol1bg -eq 1 ]]
    then
        printf "\nColumn 1 background = default (%s)" "${match_arr[$col1bg]}"
    else
        printf "\nColumn 1 background = %d (%s)" "$(( $col1bg +1 ))" "${match_arr[$col1bg]}"
    fi

    if [[ $iscol1ft -eq 1 ]]
    then
        printf "\nColumn 1 font color = default (%s)" "${match_arr[$col1ft]}"
    else
        printf "\nColumn 1 font color = %d (%s)" "$(( $col1ft +1 ))" "${match_arr[$col1ft]}"
    fi

    if [[ $iscol2bg -eq 1 ]]
    then
        printf "\nColumn 2 background = default (%s)" "${match_arr[$col2bg]}"
    else
        printf "\nColumn 2 background = %d (%s)" "$(( $col2bg +1 ))" "${match_arr[$col2bg]}"
    fi

    if [[ $iscol2ft -eq 1 ]]
    then
        printf "\nColumn 2 font color = default (%s)\n" "${match_arr[$col2ft]}"
    else
        printf "\nColumn 2 font color = %d (%s)\n" "$(( $col2ft +1 ))" "${match_arr[$col2ft]}"
    fi
fi