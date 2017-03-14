#!/bin/bash

destDir="statsResult"
fileName="resultMPIblur_$1_"


if [ ! -d "./$destDir" ]; then
    echo "Création du $destDir !";
    mkdir $destDir
fi

suffix=0

while [ -f "$destDir/$fileName$suffix.txt" ]; do
    let "suffix += 1"
done

finalFile="$destDir/$fileName$suffix.txt"

echo "N=$1" > $finalFile

if [ -n $2 ] && [[ $2 = "-v" ]]; then
    srun -n $1 run_test.sh | tee /dev/tty | ./stats >> $finalFile
else
    srun -n $1 run_test.sh | ./stats >> $finalFile
fi
