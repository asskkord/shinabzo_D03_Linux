#!/bin/bash

start=$(date +%s)

if [[ $# = 1 ]]
then

    if [[ $1 == */ ]]
    then

        printf "Total number of folders (including all nested ones) = %s\n" "$(( $(find $1 -type d | wc -l) - 1 ))"

        printf "TOP 5 folders of maximum size arranged in descending order (path and size):\n"
        counter_dirs=1
        du $1 | sort -n -r | head -5 | while read line; do
            if [[ $1 == . ]]; then continue; fi
            printf "%d - %s, %.0f MB\n" $counter_dirs $(echo "$line" | awk '{printf $2}') $(echo "$line" | awk '{printf $1/1000}')
            counter_dirs=$(( counter_dirs + 1 ))
        done

        printf "Number of:\n"

        printf "Configuration files (with the .conf extension) = %s\n" "$(find $1 -name *.conf | wc -l)"

        printf "Text files = %s\n" "$(find $1 -type f -exec file {} \; | awk '{$1="";print $0}' | awk '/UTF|ASCII|Unicode/' | wc -l)"

        printf "Executable files = %s\n" "$(find $1 -type f -exec file {} \; | awk '{$1="";print $0}' | awk '/executable|script/' | wc -l)"

        printf "Log files (with the extension .log) = %s\n" "$(find $1 -name *.log | wc -l)"

        printf "Archive files = %s\n" "$(find $1 -type f -exec file {} \; | awk '{$1="";print $0}' | awk '/archive|tar|zip|gzip/' | wc -l)"

        printf "Symbolic links = %s\n" "$(find $1 -type l| wc -l)"

        printf "TOP 10 files of maximum size arranged in descending order (path, size and type):\n"
        counter_files=1
        find $1 -type f -printf "%s\t%p\n" | sort -nr | head -10 | while read line; do
            printf "%d - %s, %.0f MB," $counter_files $(echo "$line" | awk '{printf $2}') $(echo "$line" | awk '{printf $1/1000}')
            counter_files=$(( counter_files + 1 ))
            printf "%s\n" "$( file $(echo "$line" | awk '{printf $2}') | awk '{$1="";print $0}')"
        done

        printf "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):\n"
        echo "$(find $1 -type f -executable -exec du -h {} + | sort -hr | head -10 | cat -n | awk '{print $1" - "$3", "$2}')"

        end=$(date +%s)
        printf "Script execution time (in seconds) = %s\n" $(( end - start ))

    else
        echo "Incorrect input"
    fi
else 
    echo "Incorrect number of arguments"
fi