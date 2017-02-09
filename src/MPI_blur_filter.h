// TODO: test getNextSubImg -> done!


#ifndef DEF_MPI_BLUR_FILTER
#define DEF_MPI_BLUR_FILTER

#include <mpi.h>
#include "communDef.h"

#define ROOT 0

// blur filter constants
#define OVERLAPSIZE 5
#define THRESHOLD 20

// get sub img refSize (coef * size)
#define COEF_REFSIZE 3

#define DEV_DEBUG // TODO: comment this line

// use to split the top and the bottom of the image
// return NULL if no more sub images
// WARNING: pBuffer need to be big enough
simpleImage* getNextSubImg(pixel* inputImg, int width, int height, int overlapSize, int refSize, int reset, pixel* pBuffer);


// apply blur on inputImg
// return boolean end
int blurOneIter(simpleImage* inputImg, int size, int threshold);


// wait for an image to blur
void slaveBlur(int size, int threshold);


void mergeSubImg(pixel* result, int width, int height, simpleImage bluredImg, int size);

void killSlaves(int nbTasks);

void masterBlurOnePart(pixel* inputImg, int width, int height, int size, int threshold, int nbTasks);

// apply blur to each image
void masterBlur(animated_gif* image, int size, int threshold, int nbTasks);



int main_mpi_blur_filter(int argc, char** argv);

#endif
