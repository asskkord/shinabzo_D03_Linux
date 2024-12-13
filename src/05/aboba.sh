#!/bin/bash

counter=1
du ~/projects/ | sort -n -r | head -n 5 | while read line; do
    printf "%d - %s, %.0f MB\n" $counter $(echo "$line" | awk '{printf $2}') $(echo "$line" | awk '{printf $1/1000}')
    counter=$(( counter + 1 ))
    #echo "$line"
done