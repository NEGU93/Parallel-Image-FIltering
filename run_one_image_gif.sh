make

INPUT_DIR=images/original
OUTPUT_DIR=images/processed
mkdir $OUTPUT_DIR 2>/dev/null

vect=(051009.vince.gif 200_s.gif australian-flag-large.gif Campusplan-Hausnr.gif Campusplan-Mobilitaetsbeschraenkte.gif frame_002.gif porsche.gif Produits_sous_linux.gif)

for i in "${vect[@]}"; do
    DEST=$OUTPUT_DIR/`basename $i .gif`-sobel.gif
    echo "Running test on $i -> $DEST"

    ./sobelf $INPUT_DIR/$i $DEST
done