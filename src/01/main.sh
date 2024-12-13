#!/bin/bash

if [[ $1 =~ ^-?[0-9]+$ ]]
then
    echo 'Input is incorrect'
else
    echo $1
fi