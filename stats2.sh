#!/bin/bash

destDir="stats2Result"
fileName="resultMPIblur_$1_"
timeRef="timeReference.txt"

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
    srun -n $1 run_test.sh | tee /dev/tty | ./stats2 $timeRef >> $finalFile
else
    srun -n $1 run_test.sh | ./stats2 $timeRef >> $finalFile
fi
