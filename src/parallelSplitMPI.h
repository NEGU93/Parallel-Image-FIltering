#ifndef DEF_PARALLEL_SPLIT_MPI_H
#define DEF_PARALLEL_SPLIT_MPI_H

#include <mpi.h>

#include "communDef.h"

// fill int[4] output with corner top left and corner bottom right of the img for blur (precise the rank in each dim)
// return 0 if no work for task myRank
int getPartBlur(int height, int width, int size, int myRank, int nbTasks, int* output, int* rank2dim, int* groupDim);

int getPartGlobal(int height, int width, int myRank, int nbTasks, int* output, int* rank2dim, int* groupDim);

// extract part of inputImg
void copyImg(pixel* input, pixel* output, int inputWidth, int offsetX, int offsetY, int height, int width);
// write a part of outputImg
void writeImg(pixel* input, pixel* output, int inputWidth, int offsetX, int offsetY, int height, int width);

// send a part of input
void send(pixel* input, int inputWidth, int offsetX, int offsetY, int height, int width, int targetRank);
//receive a part of output
void recv(pixel* output, int outputWidth, int offsetX, int offsetY, int height, int width, int sourceRank);

void blurFilter(animated_gif* image, int size, int threshold);

int mainParallelSplitMPI(int argc, char** argv);

#endif
