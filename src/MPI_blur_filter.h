// TODO: test getNextSubImg -> done!


#ifndef DEF_MPI_BLUR_FILTER
#define DEF_MPI_BLUR_FILTER

#include "communDef.h"

// use to split the top and the bottom of the image
// return simpleImage of size 0x0 when no more sub images
// WARNING: pBuffer need to be big enough
simpleImage getNextSubImg(pixel* inputImg, int width, int height, int overlapSize, int refSize, int reset, pixel* pBuffer);

int main_mpi_blur_filter(int argc, char** argv);

#endif
