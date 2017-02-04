#ifndef DEF_PARALLEL_BLUR_H
#define DEF_PARALLEL_BLUR_H

#include "communDef.h"

int splitImage(int inputWidth, int inputHeight, int* heightOffset, int* widthOffset, int* destTopOffset, int* destBottomOffset, int* subWidth, int* subHeight, int overlapSize);

int getSubImage(animated_gif* inputImage, int numImg, simpleImage* destImg, int* heightOffset, int* widthOffset, int myNum);

int fillSubImagesArray(animated_gif* inputImage, int numImg, simpleImage* destImgArray, int* heightOffset, int* widthOffset, int nbSubImg);

int mergeSubImg(pixel* new, int width, pixel* img, int hOBegin, int hOEnd, int wOBegin, int wOEnd, int size);

int one_iter_blur_filter(simpleImage* image, int size, int threshold, int topOffset, int bottomOffset);

void apply_blur_filter_dynamic(animated_gif* img, int size, int threshold);

int main_parallel_blur(int argc, char** argv);

#endif
