#!/bin/bash

INPUT_DIR=images/originalFiltered
OUTPUT_DIR=images/processed

for i in $INPUT_DIR/*gif ; do
    DEST=$OUTPUT_DIR/`basename $i .gif`.gif

	diff $i $DEST
done
