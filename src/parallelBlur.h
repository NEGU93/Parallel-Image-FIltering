#ifndef DEF_PARALLEL_BLUR_H
#define DEF_PARALLEL_BLUR_H

#include <math.h>

#include "communDef.h"

// fill int[4] output with corner top left and corner bottom right of the img for blur
// return 0 if no work for task myRank
int getPart(int height, int width, int size, int myRank, int nbTasks, int* output);

#endif
