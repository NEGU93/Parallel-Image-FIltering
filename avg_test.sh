#!/bin/bash

make

INPUT_DIR=images/original
$INPUT_DIR/1.gif            # Image to test
N = 10
OUTPUT_DIR=images/processed
mkdir $OUTPUT_DIR 2>/dev/null

for i in N ; do
    DEST=$OUTPUT_DIR/`basename $i .gif`-sobel.gif
    echo "Running test on $i -> $DEST"

    ./sobelf $i $DEST
done
