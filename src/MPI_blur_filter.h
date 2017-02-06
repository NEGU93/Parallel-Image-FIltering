// TODO: test getNextSubImg -> done!


#ifndef DEF_MPI_BLUR_FILTER
#define DEF_MPI_BLUR_FILTER

#include <mpi.h>
#include "communDef.h"

#define ROOT 0

// blur filter constants
#define OVERLAPSIZE 5
#define THRESHOLD 20

// use to split the top and the bottom of the image
// return simpleImage of size 0x0 when no more sub images
// WARNING: pBuffer need to be big enough
simpleImage getNextSubImg(pixel* inputImg, int width, int height, int overlapSize, int refSize, int reset, pixel* pBuffer);


// apply blur on inputImg
// return boolean end
int blurOneIter(simpleImage* inputImg, int size, int threshold);


// wait for an image to blur
void slaveBlur(int size, int threshold);

// apply blur to each image
void masterBlur(animated_gif* image, int size, int threshold);



int main_mpi_blur_filter(int argc, char** argv);

#endif
