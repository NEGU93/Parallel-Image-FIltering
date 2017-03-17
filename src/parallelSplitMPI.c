#include "parallelSplitMPI.h"

MPI_Comm localComm;

int mainParallelSplitMPI(int argc, char** argv)
{
    int myRank;
    MPI_Comm_rank(MPI_COMM_WORLD, &myRank);

    if(argc < 3)
    {
        fprintf( stderr, "Usage: %s input.gif output.gif \n", argv[0]);
#ifdef DEV_DEBUG
        fprintf(stderr, "Abort on line %d\n\n", __LINE__);
#endif
        fflush(stderr);
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    char* input_filename;
    char* output_filename;
    animated_gif* image;
    struct timeval t1, t2;
    double duration;

    input_filename = argv[1] ;
    output_filename = argv[2] ;

    /* IMPORT Timer start */
    gettimeofday(&t1, NULL);

    /* Load file and store the pixels in array */
    image = load_pixels( input_filename ) ;
    if ( image == NULL ) { return 1 ; }

    /* IMPORT Timer stop */
    gettimeofday(&t2, NULL);

    duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

    if(myRank == ROOT)
        printf("L %lf\n", duration);

    //**************************************************

    /* FILTER Timer start */
    gettimeofday(&t1, NULL);

    /* Convert the pixels into grayscale */
    apply_gray_filter( image ) ;

    /* FILTER Timer stop */
    gettimeofday(&t2, NULL);

    duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

    if(myRank == ROOT)
        printf("G %lf\n", duration);

    //**************************************************

    /* FILTER Timer start */
    gettimeofday(&t1, NULL);

    /* Apply blur filter with convergence value */
    blurFilter(image, OVERLAPSIZE, THRESHOLD, MPI_COMM_WORLD);

    /* FILTER Timer stop */
    gettimeofday(&t2, NULL);

    duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

    if(myRank == ROOT)
        printf("B %lf\n", duration);

    //**************************************************

    if(myRank == ROOT) // TODO: parallel
    {
        /* FILTER Timer start */
        gettimeofday(&t1, NULL);

        /* Apply sobel filter on pixels */
        apply_sobel_filter( image ) ;

        /* FILTER Timer stop */
        gettimeofday(&t2, NULL);

        duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

        printf("S %lf\n", duration);

        /* EXPORT Timer start */
        gettimeofday(&t1, NULL);

        /* Store file from array of pixels to GIF file */
        if ( !store_pixels( output_filename, image ) ) { return 1 ; }

        /* EXPORT Timer stop */
        gettimeofday(&t2, NULL);

        duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

        printf("E %lf\n", duration);
    }

    return 0;
}

// size of N tiles in h*w
void getDimSize(int h, int w, int N, int size, int* dim)
{
    int maxX = MAX(h / size,1);
    int maxY = MAX(w / size,1);

    int nbX = (int)sqrt(N * h / w);
    nbX = (nbX > 0) ? nbX : 1;
    nbX = MIN(nbX,maxX);
    int nbY = N / nbX;
    nbY = (nbY > 0) ? nbY : 1;
    nbY = MIN(nbY,maxY);

    dim[0] = nbX;
    dim[1] = nbY;
}

int getPartBlur(int height, int width, int size, int myRank, int nbTasks, int* output, int* rank2dim, int* groupDim)
{
    int groupSize = nbTasks / 2; // one on top and one on bottom

    int stripeHeight;
    if(myRank < groupSize)
    {
	stripeHeight = height / 10 - (2*size);
    }
    else
    {
	int tmp = height * 0.9;
	stripeHeight = height - tmp - (2*size);
    }

    int stripeWidth = width - (2 * size);

    if(stripeHeight <= 0 || stripeWidth <= 0)
    {
	return 0; // no work to do
    }

    int dimSize[2];
    int adjustedSize = groupSize + ((nbTasks % 2 != 0 && myRank >= groupSize) ? 1 : 0); // add one to bottom group if odd number of tasks
    getDimSize(stripeHeight, stripeWidth, adjustedSize, size, dimSize);

/* old version
   int nbX = stripeHeight / tileSize[0];
   int nbY = stripeWidth / tileSize[1];
   int nbOverX = stripeHeight % tileSize[0];
   int nbOverY = stripeWidth % tileSize[1];
*/
    int nbX = dimSize[0];
    int nbY = dimSize[1];

    int tileSize[2];
    tileSize[0] = stripeHeight / nbX;
    tileSize[1] = stripeWidth / nbY;
    int nbOverX = stripeHeight % tileSize[0];
    int nbOverY = stripeWidth % tileSize[1];

    int offsetX = size;
    int offsetY = size;

    if(myRank >= groupSize) // on bottom ?
    {
        offsetX = height - size - stripeHeight;
        myRank -= groupSize;
    }

    int x = myRank / nbY;
    int y = myRank % nbY;
    if(x >= nbX)
    {
        return 0; // no work for this task
    }

    output[0] = offsetX + (x * tileSize[0]) + ((x < nbOverX) ? x : nbOverX);
    output[1] = offsetY + (y * tileSize[1]) + ((y < nbOverY) ? y : nbOverY);
    output[2] = output[0] + tileSize[0] + ((x < nbOverX) ? 1 : 0);
    output[3] = output[1] + tileSize[1] + ((y < nbOverY) ? 1 : 0);

    rank2dim[0] = x;
    rank2dim[1] = y;

    groupDim[0] = nbX;
    groupDim[1] = nbY;

    return 1;
}

/*
  int getPartGlobal(int height, int width, int myRank, int nbTasks, int* output, int* rank2dim, int* groupDim)
  {
  int tileSize[2];
  getTileSize(height, width, nbTasks, tileSize);

  int nbX = height / tileSize[0];
  int nbY = width / tileSize[1];
  int nbOverX = height % tileSize[0];
  int nbOverY = width % tileSize[1];

  int x = myRank / nbY;
  int y = myRank % nbY;
  if(x >= nbX)
  {
  return 0; // no work for this task
  }

  output[0] = (x * tileSize[0]) + ((x < nbOverX) ? x : nbOverX);
  output[1] = (y * tileSize[1]) + ((y < nbOverY) ? y : nbOverY);
  output[2] = output[0] + tileSize[0] + ((x < nbOverX) ? 1 : 0);
  output[3] = output[1] + tileSize[1] + ((y < nbOverY) ? 1 : 0);

  rank2dim[0] = x;
  rank2dim[1] = y;

  groupDim[0] = nbX;
  groupDim[1] = nbY;

  return 1;
  }
*/

void copyImg(pixel* input, pixel* output, int inputWidth, int offsetX, int offsetY, int height, int width)
{
    int i,j;

    for(i = 0; i < height; i++)
    {
        for(j = 0; j < width; j++)
        {
            output[CONV(i,j,width)].r = input[CONV(offsetX + i, offsetY + j, inputWidth)].r;
            output[CONV(i,j,width)].g = input[CONV(offsetX + i, offsetY + j, inputWidth)].g;
            output[CONV(i,j,width)].b = input[CONV(offsetX + i, offsetY + j, inputWidth)].b;
        }
    }
}

void writeImg(pixel* input, pixel* output, int outputWidth, int offsetX, int offsetY, int height, int width)
{
    int i,j;

    for(i = 0; i < height; i++)
    {
        for(j = 0; j < width; j++)
        {
            output[CONV(offsetX + i, offsetY + j, outputWidth)].r = input[CONV(i, j, width)].r;
            output[CONV(offsetX + i, offsetY + j, outputWidth)].g = input[CONV(i, j, width)].g;
            output[CONV(offsetX + i, offsetY + j, outputWidth)].b = input[CONV(i, j, width)].b;
        }
    }
}

#if 1
void mon_send(pixel* input, int inputWidth, int offsetX, int offsetY, int height, int width, int targetRank)
{
    pixel* buffer;
    int size = height * width * sizeof(pixel);
    buffer = (pixel*)malloc(size);

    // fill buffer
    copyImg(input, buffer, inputWidth, offsetX, offsetY, height, width);

    // send to targetRank
    MPI_Send(buffer, size, MPI_BYTE, targetRank, 0, localComm);

    free(buffer);
}

void mon_recv(pixel* output, int outputWidth, int offsetX, int offsetY, int height, int width, int sourceRank)
{
    pixel* buffer;
    int size = height * width * sizeof(pixel);
    buffer = (pixel*)malloc(size);

    // recv from sourceRank
    MPI_Status s;
    MPI_Recv(buffer, size, MPI_BYTE, sourceRank, 0, localComm, &s);

    // write in output
    writeImg(buffer, output, outputWidth, offsetX, offsetY, height, width);

    free(buffer);
}

void sendRecvOverlaps(pixel* myImg, int myRank, int* myDimRank, int* myDimGroup, int myHeight, int myWidth, int size)
{
// recv overlaps area from left, top left, top, top right
    if(myDimRank[0] > 0)
    {
	if(myDimRank[1] > 0)
	{
	    // from top left
	    mon_recv(myImg, myWidth,
		     0, 0,
		     size, size,
		     myRank - myDimGroup[1] -1);
	}

	// from top
	mon_recv(myImg, myWidth,
		 0, size,
		 size, myWidth - 2*size,
		 myRank - myDimGroup[1]);

	if(myDimRank[1] < myDimGroup[1] - 1)
	{
	    // from top right
	    mon_recv(myImg, myWidth,
		     0, myWidth - size,
		     size, size,
		     myRank - myDimGroup[1] + 1);
	}
    }

    if(myDimRank[1] > 0)
    {
	// from left
	mon_recv(myImg, myWidth,
		 size, 0,
		 myHeight - 2*size, size,
		 myRank - 1);
    }

    /******************************/

    // send overlaps area to all neighbors
    if(myDimRank[0] > 0)
    {
	if(myDimRank[1] > 0)
	{
	    // to top left
	    mon_send(myImg, myWidth,
		     size, size,
		     size, size,
		     myRank - myDimGroup[1] - 1);
	}

	// to top
	mon_send(myImg, myWidth,
		 size, size,
		 size, myWidth - 2*size,
		 myRank - myDimGroup[1]);

	if(myDimRank[1] < myDimGroup[1] - 1)
	{
	    // to top right
	    mon_send(myImg, myWidth,
		     size, myWidth - 2*size,
		     size, size,
		     myRank - myDimGroup[1] + 1);
	}
    }

    if(myDimRank[1] > 0)
    {
	// to left
	mon_send(myImg, myWidth,
		 size, size,
		 myHeight - 2*size, size,
		 myRank - 1);
    }

    if(myDimRank[1] < myDimGroup[1] - 1)
    {
	// to right
	mon_send(myImg, myWidth,
		 size, myWidth - 2*size,
		 myHeight - 2*size, size,
		 myRank + 1);
    }

    if(myDimRank[0] < myDimGroup[0] - 1)
    {
	if(myDimRank[1] > 0)
	{
	    // to bottom left
	    mon_send(myImg, myWidth,
		     myHeight - 2*size, size,
		     size, size,
		     myRank + myDimGroup[1] - 1);
	}

	// to bottom
	mon_send(myImg, myWidth,
		 myHeight - 2*size, size,
		 size, myWidth - 2*size,
		 myRank + myDimGroup[1]);

	if(myDimRank[1] < myDimGroup[1] - 1)
	{
	    // to bottom right
	    mon_send(myImg, myWidth,
		     myHeight - 2*size, myWidth - 2*size,
		     size, size,
		     myRank + myDimGroup[1] + 1);
	}
    }

    /******************************/

    // recv overlaps area from right, bottom left, bottom, bottom right
    if(myDimRank[0] < myDimGroup[0] - 1)
    {
	if(myDimRank[1] > 0)
	{
	    // from bottom left
	    mon_recv(myImg, myWidth,
		     myHeight - size, 0,
		     size, size,
		     myRank + myDimGroup[1] -1);
	}

	// from bottom
	mon_recv(myImg, myWidth,
		 myHeight - size, size,
		 size, myWidth - 2*size,
		 myRank + myDimGroup[1]);

	if(myDimRank[1] < myDimGroup[1] - 1)
	{
	    // from bottom right
	    mon_recv(myImg, myWidth,
		     myHeight - size, myWidth - size,
		     size, size,
		     myRank + myDimGroup[1] + 1);
	}
    }

    if(myDimRank[1] < myDimGroup[1] - 1)
    {
	// from right
	mon_recv(myImg, myWidth,
		 size, myWidth - size,
		 myHeight - 2*size, size,
		 myRank + 1);
    }
}


// same as "sendRecvOverlaps" but with better performances
void sendRecvOverlaps2(pixel* myImg, int myRank, int* myDimRank, int* myDimGroup, int myHeight, int myWidth, int size)
{
    /******************************/
    /*    horizontal exchange     */
    /******************************/
    // even n <-> odd n+1
    if(myDimRank[1] % 2)
    {
	// odd
	// from left
	mon_recv(myImg, myWidth,
		 size, 0,
		 myHeight - 2*size, size,
		 myRank - 1);

	// to left
	mon_send(myImg, myWidth,
		 size, size,
		 myHeight - 2*size, size,
		 myRank - 1);	
    }
    else
    {
	// even
	if(myDimRank[1] < myDimGroup[1] - 1)
	{
	    // to right
	    mon_send(myImg, myWidth,
		     size, myWidth - 2*size,
		     myHeight - 2*size, size,
		     myRank + 1);
	    
	    // from right
	    mon_recv(myImg, myWidth,
		     size, myWidth - size,
		     myHeight - 2*size, size,
		     myRank + 1);
	}
    }

    // odd n <-> even n+1
    if(myDimRank[1] % 2)
    {
	// odd
	if(myDimRank[1] < myDimGroup[1] - 1)
	{
	    // to right
	    mon_send(myImg, myWidth,
		     size, myWidth - 2*size,
		     myHeight - 2*size, size,
		     myRank + 1);
	    
	    // from right
	    mon_recv(myImg, myWidth,
		     size, myWidth - size,
		     myHeight - 2*size, size,
		     myRank + 1);
	}	
    }
    else
    {
	// even
	if(myDimRank[1] > 0)
	{
	    // from left
	    mon_recv(myImg, myWidth,
		     size, 0,
		     myHeight - 2*size, size,
		     myRank - 1);
	    
	    // to left
	    mon_send(myImg, myWidth,
		     size, size,
		     myHeight - 2*size, size,
		     myRank - 1);
	}	
    }

    /******************************/
    /*     Vertical Exchange      */
    /******************************/
    // even n <-> odd n+1
    if(myDimRank[0] % 2)
    {
	// odd
        // from top
	mon_recv(myImg, myWidth,
		 0, size,
		 size, myWidth - 2*size,
		 myRank - myDimGroup[1]);

	// to top
	mon_send(myImg, myWidth,
		 size, size,
		 size, myWidth - 2*size,
		 myRank - myDimGroup[1]);
    }
    else
    {
	// even
	if(myDimRank[0] < myDimGroup[0] - 1)
	{
	    // to bottom
	    mon_send(myImg, myWidth,
		     myHeight - 2*size, size,
		     size, myWidth - 2*size,
		     myRank + myDimGroup[1]);

	    // from bottom
	    mon_recv(myImg, myWidth,
		     myHeight - size, size,
		     size, myWidth - 2*size,
		     myRank + myDimGroup[1]);
	}
    }

    // odd n <-> even n+1
    if(myDimRank[0] % 2)
    {
	// odd
	if(myDimRank[0] < myDimGroup[0] - 1)
	{
	    // to bottom
	    mon_send(myImg, myWidth,
		     myHeight - 2*size, size,
		     size, myWidth - 2*size,
		     myRank + myDimGroup[1]);

	    // from bottom
	    mon_recv(myImg, myWidth,
		     myHeight - size, size,
		     size, myWidth - 2*size,
		     myRank + myDimGroup[1]);	    
	}
    }
    else
    {
	// even
	if(myDimRank[0] > 0)
	{
	    // from top
	    mon_recv(myImg, myWidth,
		     0, size,
		     size, myWidth - 2*size,
		     myRank - myDimGroup[1]);
	    
	    // to top
	    mon_send(myImg, myWidth,
		     size, size,
		     size, myWidth - 2*size,
		     myRank - myDimGroup[1]);
	}
    }

    /******************************/
    /*  Top Left / Bottom Right   */
    /******************************/
    // even row n <-> odd row n+1
    if(myDimRank[0] % 2)
    {
	// odd row
	if(myDimRank[1] > 0)
	{
	    // from top left
	    mon_recv(myImg, myWidth,
		     0, 0,
		     size, size,
		     myRank - myDimGroup[1] -1);

	    // to top left
	    mon_send(myImg, myWidth,
		     size, size,
		     size, size,
		     myRank - myDimGroup[1] - 1);
	}
    }
    else
    {
	// even row
	if(myDimRank[0] < myDimGroup[0] - 1 && myDimRank[1] < myDimGroup[1] - 1)
	{
	    // to bottom right
	    mon_send(myImg, myWidth,
		     myHeight - 2*size, myWidth - 2*size,
		     size, size,
		     myRank + myDimGroup[1] + 1);

	    // from bottom right
	    mon_recv(myImg, myWidth,
		     myHeight - size, myWidth - size,
		     size, size,
		     myRank + myDimGroup[1] + 1);
	}
    }

    // odd row n <-> even row n+1
    if(myDimRank[0] % 2)
    {
	// odd row
	if(myDimRank[0] < myDimGroup[0] - 1 && myDimRank[1] < myDimGroup[1] - 1)
	{
	    // to bottom right
	    mon_send(myImg, myWidth,
		     myHeight - 2*size, myWidth - 2*size,
		     size, size,
		     myRank + myDimGroup[1] + 1);

	    // from bottom right
	    mon_recv(myImg, myWidth,
		     myHeight - size, myWidth - size,
		     size, size,
		     myRank + myDimGroup[1] + 1);
	}
    }
    else
    {
	// even row
	if(myDimRank[0] > 0 && myDimRank[1] > 0)
	{
	    // from top left
	    mon_recv(myImg, myWidth,
		     0, 0,
		     size, size,
		     myRank - myDimGroup[1] -1);

	    // to top left
	    mon_send(myImg, myWidth,
		     size, size,
		     size, size,
		     myRank - myDimGroup[1] - 1);
	}
    }

    /******************************/
    /*  Top Right / Bottom Left   */
    /******************************/
    // even row n <-> odd row n+1
    if(myDimRank[0] % 2)
    {
	// odd row
	if(myDimRank[1] < myDimGroup[1] - 1)
	{
	    // from top right
	    mon_recv(myImg, myWidth,
		     0, myWidth - size,
		     size, size,
		     myRank - myDimGroup[1] + 1);

	    // to top right
	    mon_send(myImg, myWidth,
		     size, myWidth - 2*size,
		     size, size,
		     myRank - myDimGroup[1] + 1);	    
	}
    }
    else
    {
	// even row
	if(myDimRank[1] > 0 && myDimRank[0] < myDimGroup[0] - 1)
	{
	    // to bottom left
	    mon_send(myImg, myWidth,
		     myHeight - 2*size, size,
		     size, size,
		     myRank + myDimGroup[1] - 1);

	    // from bottom left
	    mon_recv(myImg, myWidth,
		     myHeight - size, 0,
		     size, size,
		     myRank + myDimGroup[1] -1);	    
	}
    }

    // odd row n <-> even row n+1
    if(myDimRank[0] % 2)
    {
	// odd row
	if(myDimRank[0] < myDimGroup[0] - 1)
	{
	    // to bottom left
	    mon_send(myImg, myWidth,
		     myHeight - 2*size, size,
		     size, size,
		     myRank + myDimGroup[1] - 1);

	    // from bottom left
	    mon_recv(myImg, myWidth,
		     myHeight - size, 0,
		     size, size,
		     myRank + myDimGroup[1] -1);	    
	}
    }
    else
    {
	// even row
	if(myDimRank[0] > 0 && myDimRank[1] < myDimGroup[1] - 1)
	{
	    // from top right
	    mon_recv(myImg, myWidth,
		     0, myWidth - size,
		     size, size,
		     myRank - myDimGroup[1] + 1);

	    // to top right
	    mon_send(myImg, myWidth,
		     size, myWidth - 2*size,
		     size, size,
		     myRank - myDimGroup[1] + 1);	    
	}
    }
}


void updateImg(pixel* p, int pHeight, int pWidth, pixel* myImg, int myRank, int nbTasks, int* shape, int size)
{
    if(myRank == ROOT)
    {
	int nbToWait;
	int srcTask;
	int srcTag;
	MPI_Status s;
	int extractHeight;
	int extractWidth;
	pixel* buffer;

	buffer = (pixel*)malloc(pHeight * pWidth * sizeof(pixel));

	// write root part
	extractHeight = shape[2] - shape[0];
	extractWidth = shape[3] - shape[1];
	copyImg(myImg, buffer, extractWidth + 2*size, size, size, extractHeight, extractWidth);
	writeImg(buffer, p, pWidth, shape[0], shape[1], shape[2] - shape[0], shape[3] - shape[1]);

	// get other tasks part
	for(nbToWait = nbTasks - 1; nbToWait > 0; nbToWait--) // each task sends to root
	{
	    MPI_Recv(shape, 4, MPI_INT, MPI_ANY_SOURCE, MPI_ANY_TAG, localComm, &s);

	    if(shape[0] < 0) // no work task
	    {
		fprintf(stderr, "Unexpected case\n");
		continue;
	    }

	    srcTask = s.MPI_SOURCE;
	    srcTag = s.MPI_TAG;

	    //printf("Get from %d\n", srcTask); // debug
	    //fflush(stdout);

	    extractHeight = shape[2] - shape[0];
	    extractWidth = shape[3] - shape[1];

	    MPI_Recv(buffer, extractHeight * extractWidth * sizeof(pixel), MPI_BYTE, srcTask, srcTag+1, localComm, &s);
	    writeImg(buffer, p, pWidth, shape[0], shape[1], extractHeight, extractWidth);
	}

	free(buffer);
    }
    else if(shape[0] >= 0)
    {
	int extractHeight = shape[2] - shape[0];
	int extractWidth = shape[3] - shape[1];
	int sizeBuf = extractHeight * extractWidth * sizeof(pixel);
	pixel* buffer = (pixel*)malloc(sizeBuf);
	copyImg(myImg, buffer, extractWidth + 2*size, size, size, extractHeight, extractWidth);

	MPI_Send(shape, 4, MPI_INT, ROOT, myRank, localComm);
	MPI_Send(buffer, sizeBuf, MPI_BYTE, ROOT, myRank+1, localComm);
    }
    else
    {
	fprintf(stderr, "Unexpected case\n");
	MPI_Send(shape, 4, MPI_INT, ROOT, myRank, MPI_COMM_WORLD);
    }
}

int blurOnePart(pixel* myImg, pixel* newp, int myHeight, int myWidth, int size, int threshold)
{
    int j,k;
    int end;

    end = 1;

    // apply blur
    for(j = size; j < myHeight - size; j++)
    {
	for(k = size; k < myWidth - size; k++)
	{
	    int stencil_j, stencil_k ;
	    int t_r = 0 ;
	    int t_g = 0 ;
	    int t_b = 0 ;

	    for ( stencil_j = -size ; stencil_j <= size ; stencil_j++ )
	    {
		for ( stencil_k = -size ; stencil_k <= size ; stencil_k++ )
		{
		    t_r += myImg[CONV(j+stencil_j,k+stencil_k,myWidth)].r ;
		    t_g += myImg[CONV(j+stencil_j,k+stencil_k,myWidth)].g ;
		    t_b += myImg[CONV(j+stencil_j,k+stencil_k,myWidth)].b ;
		}
	    }

	    newp[CONV(j,k,myWidth)].r = t_r / ( (2*size+1)*(2*size+1) ) ;
	    newp[CONV(j,k,myWidth)].g = t_g / ( (2*size+1)*(2*size+1) ) ;
	    newp[CONV(j,k,myWidth)].b = t_b / ( (2*size+1)*(2*size+1) ) ;
	}
    }

    // actu img and end ?
    for(j = size; j < myHeight - size; j++)
    {
	for(k = size; k < myWidth - size; k++)
	{
	    float diff_r;
	    float diff_g;
	    float diff_b;

	    diff_r = newp[CONV(j,k,myWidth)].r - myImg[CONV(j,k,myWidth)].r;
	    diff_g = newp[CONV(j,k,myWidth)].g - myImg[CONV(j,k,myWidth)].g;
	    diff_b = newp[CONV(j,k,myWidth)].b - myImg[CONV(j,k,myWidth)].b;

	    if ( diff_r > threshold || -diff_r > threshold
		 ||
		 diff_g > threshold || -diff_g > threshold
		 ||
		 diff_b > threshold || -diff_b > threshold
		) {
		end = 0 ;
	    }

	    myImg[CONV(j,k,myWidth)].r = newp[CONV(j,k,myWidth)].r;
	    myImg[CONV(j,k,myWidth)].g = newp[CONV(j,k,myWidth)].g;
	    myImg[CONV(j,k,myWidth)].b = newp[CONV(j,k,myWidth)].b;
	}
    }

    return end;
}

void oneImageBlur(animated_gif* image, int size, int threshold, MPI_Comm myComm, int indexImg)
{
    int i = indexImg;

    int j,k;
    int width, height;
    int end = 0;
    int n_iter = 0;

    pixel** p;
    pixel* newp;

    int shape[4];
    int myDimRank[2];
    int myDimGroup[2];
    int myWidth;
    int myHeight;
    pixel* myImg;

    int myOldRank;
    int oldNbTasks;
	
    MPI_Comm_size(myComm, &oldNbTasks);
    MPI_Comm_rank(myComm, &myOldRank);
	
    p = image->p;

    n_iter = 0;
    width = image->width[i];
    height = image->height[i];

    if(oldNbTasks > 1 && getPartBlur(height, width, size, myOldRank, oldNbTasks, shape, myDimRank, myDimGroup))
    {
	int nbTasks;
	int myRank;

	MPI_Comm_split(myComm, 1, myOldRank, &localComm);
	MPI_Comm_size(localComm, &nbTasks);
	MPI_Comm_rank(localComm, &myRank);

//	    printf("%d : (x,y) -> (%d/%d,%d/%d)\n", myRank, myDimRank[0], myDimGroup[0], myDimRank[1], myDimGroup[1]); // debug
//	    printf("shape %d : [%d,%d,%d,%d]\n", myRank, shape[0], shape[1], shape[2], shape[3]);
//	    fflush(stdout);

	myHeight = shape[2] - shape[0] + 2*size;
	myWidth = shape[3] - shape[1] + 2*size;
	// allocate array of pixels (with overlaps)
	myImg = (pixel*)malloc(myHeight * myWidth * sizeof(pixel));

	// copy part of the original image (with overlaps)
	copyImg(p[i], myImg, width, shape[0] - size, shape[1] - size, myHeight, myWidth);

	// allocate array of newp pixels (with unused overlaps) (* TODO: remove overlaps *)
	newp = (pixel*)malloc(myHeight * myWidth * sizeof(pixel));

	do
	{
	    n_iter++;

	    if(n_iter > 0)
	    {
//		    sendRecvOverlaps(myImg, myRank, myDimRank, myDimGroup, myHeight, myWidth, size);
		sendRecvOverlaps2(myImg, myRank, myDimRank, myDimGroup, myHeight, myWidth, size);
	    }

	    end = blurOnePart(myImg, newp, myHeight, myWidth, size, threshold);

	    int endReduce;
	    MPI_Allreduce(&end, &endReduce, 1, MPI_INT, MPI_MIN, myComm);
	    end = endReduce;

	} while(threshold > 0 && !end);

	// write new image in root
	updateImg(p[i], height, width, myImg, myRank, nbTasks, shape, size);

	free(myImg);
	free(newp);
    }
    else if(oldNbTasks < 2)
    {
	int myHeight2, myWidth2;
	pixel* myImg2;
	pixel* newp2;

	// top
	myHeight = height / 10;
	myWidth = width;
	myImg = (pixel*)malloc(myHeight*myWidth * sizeof(pixel));
	newp = (pixel*)malloc(myHeight*myWidth * sizeof(pixel));
	copyImg(p[i], myImg, width, 0, 0, myHeight, myWidth);

	// bottom
	myHeight2 = height*0.9;
	myHeight2 = height - myHeight2;
	myWidth2 = width;
	myImg2 = (pixel*)malloc(myHeight2*myWidth2 * sizeof(pixel));
	newp2 = (pixel*)malloc(myHeight2*myWidth2 * sizeof(pixel));
	copyImg(p[i], myImg2, width, height - myHeight2, 0, myHeight2, myWidth2);

	do
	{
	    n_iter++;
	    end = 1;

	    // top
	    end = blurOnePart(myImg, newp, myHeight, myWidth, size, threshold) && end;

	    // bottom
	    end = blurOnePart(myImg2, newp2, myHeight2, myWidth2, size, threshold) && end;

	} while(threshold > 0 && !end);

	// update p[i]
	writeImg(myImg, p[i], width, 0, 0, myHeight, myWidth);
	writeImg(myImg2, p[i], width, height-myHeight2, 0, myHeight2, myWidth2);


	free(myImg);
	free(myImg2);
	free(newp);
	free(newp2);
    }
    else
    {
	MPI_Comm_split(myComm, 0, myOldRank, &localComm);
/*
// no work for this task
do
{
end = 1;
int endReduce;
MPI_Allreduce(&end, &endReduce, 1, MPI_INT, MPI_LAND, MPI_COMM_WORLD);
end = endReduce;
} while(threshold > 0 && !end);

shape[0] = shape[1] = shape[2] = shape[3] = -1;
updateImg(NULL, 0, 0, NULL, myRank, nbTasks, shape, size);
*/
    }
}

void blurFilter(animated_gif* image, int size, int threshold, MPI_Comm myComm)
{
    int i;

    for(i = 0; i < image->n_images; i++)
    {
	oneImageBlur(image,size,threshold,myComm,i);
    }
}
#endif