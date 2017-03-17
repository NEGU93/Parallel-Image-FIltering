make

INPUT_DIR=images/original
OUTPUT_DIR=images/processed
mkdir $OUTPUT_DIR 2>/dev/null

vect=(1.gif 9815573.gif fire.gif giphy-3.gif Mandelbrot-large.gif TimelyHugeGnu.gif tumblr_myxlbtwVEb1qzt4vjo1_r14_500_large.gif)

for i in "${vect[@]}"; do
    DEST=$OUTPUT_DIR/`basename $i .gif`-sobel.gif
    echo "Running test on $i -> $DEST"

    ./sobelf $INPUT_DIR/$i $DEST
done