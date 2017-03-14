#!/bin/bash

regex='^[0-9]+$'

for var in "$@"; do
    if ! [[ $var =~ $regex ]]; then
	echo "Error: $var is not a number!"
	exit 1
    fi
done


# all args ok
for var in "$@"; do
    echo "bash stats.sh $var"
    time bash stats.sh $var
done