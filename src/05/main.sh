#!/bin/bash

printf "Total number of folders (including all nested ones) = %s\n" "$(( $(find $1 -type d | wc -l) - 1 ))"

printf "TOP 5 folders of maximum size arranged in descending order (path and size):\n"

counter=1
du $1 | sort -n -r | head -n 5 | while read line; do
    printf "%d - %s, %.0f MB\n" $counter $(echo "$line" | awk '{printf $2}') $(echo "$line" | awk '{printf $1/1000}')
    counter=$(( counter + 1 ))
done

printf "Number of:\n"

printf "Configuration files (with the .conf extension) = %s\n" "$(find $1 -name *.conf | wc -l)"

printf "Text files = %s\n" "$(find $1 -type f -exec file {} \; | awk '{$1="";print $0}' | awk '/UTF|ASCII|Unicode/' | wc -l)"

printf "Executable files = %s\n" "$(find $1 -type f -exec file {} \; | awk '{$1="";print $0}' | awk '/executable|script/' | wc -l)"

printf "Log files (with the extension .log) = %s\n" "$(find $1 -name *.log | wc -l)"

printf "Archive files = %s\n" "$(find $1 -type f -exec file {} \; | awk '{$1="";print $0}' | awk '/archive|tar|zip|gzip/' | wc -l)"