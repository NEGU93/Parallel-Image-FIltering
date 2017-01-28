/**************************************************/
/* try a static distribution for the blur filter  */
/**************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <mpi.h>

#include "communDef.h"

// return the number of parts of the inputImage
// destTopOffset[i] give the limit of the 10%
int splitImage(simpleImage* inputImage, int* heightOffset, int* widthOffset, int* destTopOffset, int* destBottomOffset, int* subWidth, int* subHeight, int overlapSize)
{
    int size = overlapSize;

    if(*subWidth < overlapSize)
    {
	fprintf(stderr, "Warning: subWidth was smaler than the overlap size!\n\tsubWidth is recomputed\n");
	*subWidth = overlapSize;
    }

    if(*subHeight < overlapSize)
    {
	fprintf(stderr, "Warning: subHeight was smaler than the overlap size!\n\tsubHeight is recomputed\n");
	*subHeight = overlapSize;
    }

    int width = inputImage->width;
    int height = inputImage->height;

    int topOffset = height/10 - size;
    int bottomOffset = height*0.9 + size;

    int nbWidth = width / (*subWidth);
    if(width % (*subWidth) > 0)
	nbWidth++;

    int nbHeight = height / (*subHeight);
    if(height % (*subHeight) > 0)
	nbHeight++;

    int resultNb = nbHeight * nbWidth;

    heigthOffset = malloc(2*resultNb * sizeof(int));
    widthOffset = malloc(2*resultNb * sizeof(int));
    destTopOffset = malloc(resultNb * sizeof(int));
    destBottomOffset = malloc(resultNb * sizeof(int));
    
    int x,y;
    int index = 0;
    for(x = 0; x < nbHeight; x++)
    {
	for(y = 0; y < nbWidth; y++)
	{
	    heightOffset[2*index] = max(x * (*subHeight) - size, 0);
	    heightOffset[2*index+1] = min((x + 1) * (*subHeight) + size ,height);

	    widthOffset[2*index] = max(y * (*subWidth) - size, 0);
	    widthOffset[2*index+1] = min((y + 1) * (*subWidth) + size, width);

	    destTopOffset[index] = topOffset - heightOffset[2*index]; // nb of lines in the top 10% (if positive)
	    destBottomOffset[index] = heightOffset[2*index+1] - bottomOffset; // nb of lines in the bottom 10% (if positive)
	}
    }
    

    return resultNb;
}

// destImgArray must exist and contains nb simpleImages
int splitImage(simpleImage* inputImage, simpleImage* destImgArray, int* heightOffset, int* widthOffset, int nb)
{
    pixel** iP = inputImage->p;

    int i;
    for(i = 0; i < nb; i++)
    {
	pixel** outP = destImgArray[i].p;
	
	int hOBegin = heightOffset[2*i];
	int hOEnd = heightOffset[2*i+1];

	int wOBegin = widthOffset[2*i];
	int wOEnd = widthOffset[2*i+1];

	destImgArray[i].heigth = hOEnd - hOBegin;
	destImgArray[i].width = wOEnd - wOEnd;
	
	int x,y;
	for(x = hOBegin; x < hOEnd; x++)
	{
	    for(y = wOBegin; y < wOEnd; y++)
	    {
		outP[x-hOBegin][y-wOBegin].r = iP[x][y].r;
		outP[x-hOBegin][y-wOBegin].g = iP[x][y].g;
		outP[x-hOBegin][y-wOBegin].b = iP[x][y].b;
	    }
	}
    }
    
    return 0;
}

// topOffset = (if positive) nb of lines in the top 10%
// bottomOffset = (if positive) nb of lines in the bottom 10%
int parallel_blur_filter(simpleImage* image, int size, int threshold, int topOffset, int bottomOffset)
{

    return 0;
}


int main(int argc, char** argv)
{
    MPI_Init(&argc, &argv);

    

    MPI_Finalize();

    return 0;
}
