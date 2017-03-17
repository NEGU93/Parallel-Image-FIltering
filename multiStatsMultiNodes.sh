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
    echo "bash statsMultiNodes.sh $var"
    time bash statsMultiNodes.sh $var
done