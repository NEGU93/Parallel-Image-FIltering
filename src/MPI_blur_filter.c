#include "MPI_blur_filter.h"


int main_mpi_blur_filter(int argc, char** argv)
{
    MPI_Init(&argc, &argv);

    int myRank, nbTasks;
    MPI_Comm_size(MPI_COMM_WORLD, &nbTasks);
    MPI_Comm_rank(MPI_COMM_WORLD, &myRank);

    if(myRank == ROOT)
    {

	if(argc < 3)
	{
	    fprintf( stderr, "Usage: %s input.gif output.gif \n", argv[0]);
	    
#ifdef DEV_DEBUG
	    fprintf(stderr, "Abort on line %d\n\n", __LINE__);
#endif

	    fflush(stderr);
	    MPI_Abort(MPI_COMM_WORLD, 1);
	}


	char * input_filename ; 
	char * output_filename ;
	animated_gif * image ;
	struct timeval t1, t2;
	double duration ;
	
	
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
	
	//printf( "GIF loaded from file %s with %d image(s) in %lf s\n", input_filename, image->n_images, duration ) ; // commented by Francois
	printf("L %lf\n", duration); // added by Francois

        //**************************************************

	/* FILTER Timer start */
	gettimeofday(&t1, NULL);

	/* Convert the pixels into grayscale */
	apply_gray_filter( image ) ;

	/* FILTER Timer stop */
	gettimeofday(&t2, NULL);

	duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

	printf("G %lf\n", duration); // added by Francois

        //**************************************************

	/* FILTER Timer start */
	gettimeofday(&t1, NULL);

	/* Apply blur filter with convergence value */
//	apply_blur_filter( image, OVERLAPSIZE, THRESHOLD ) ;
	masterBlur(image, OVERLAPSIZE, THRESHOLD, nbTasks);

	/* FILTER Timer stop */
	gettimeofday(&t2, NULL);

	duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

	printf("B %lf\n", duration); // added by Francois

        //**************************************************

	/* FILTER Timer start */
	gettimeofday(&t1, NULL);

	/* Apply sobel filter on pixels */
	apply_sobel_filter( image ) ;

	/* FILTER Timer stop */
	gettimeofday(&t2, NULL);

	duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

	//printf( "SOBEL done in %lf s\n", duration ) ; // commented by Francois
	printf("S %lf\n", duration); // added by Francois

	/* EXPORT Timer start */
	gettimeofday(&t1, NULL);

	/* Store file from array of pixels to GIF file */
	if ( !store_pixels( output_filename, image ) ) { return 1 ; }

	/* EXPORT Timer stop */
	gettimeofday(&t2, NULL);

	duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);

	//printf( "Export done in %lf s in file %s\n", duration, output_filename ) ; // commented by Francois
	printf("E %lf\n", duration); // added by Francois

    }
    else // slave
    {
	slaveBlur(OVERLAPSIZE, THRESHOLD);
    }


    return 0;
}


void killSlaves(int nbTasks)
{
    int iTask;
    for(iTask = 0; iTask < nbTasks; iTask++)
    {
	if(iTask != ROOT)
	{
	    MPI_Send(NULL,0,MPI_BYTE,iTask,0,MPI_COMM_WORLD);
	}
    }
}


simpleImage* getNextSubImg(pixel* inputImg, int width, int height, int overlapSize, int refSize, int reset, pixel* pBuffer)
{
    static int x;
    static int y;

    if(reset)
    {
        x = 0;
        y = 0;
    }
    
    simpleImage* result = NULL;

    if(x >= height || refSize <= 2*overlapSize)
        return result;
    
    // assume refSize > 2*overlapSize and x < height
    int h = refSize;
    int w = refSize;

    if(y + w >= width)
    {
        w = width - y;

        if(w <= 2*overlapSize)
        {
            y = 0;
            x += refSize - 2*overlapSize;

            return getNextSubImg(inputImg, width, height, overlapSize, refSize, 0, pBuffer);
        }
    }

    if(x + h >= height)
    {
        h = height - x;

        if(h <= 2*overlapSize)
        {
            return result;
        }
    }

    result = malloc(sizeof(simpleImage));
    result->offsetX = x;
    result->offsetY = y;
    result->height = h;
    result->width = w;
    result->p = pBuffer;

//    printf("DEBUG: (x,y) = (%d,%d) | (h,w) = (%d,%d)\n", x, y, h, w);

    int i, j;
    for(i = 0; i < h; i++)
    {
        for(j = 0; j < w; j++)
        {
            pBuffer[CONV(i,j,w)].r = inputImg[CONV(x+i,y+j,width)].r;
            pBuffer[CONV(i,j,w)].g = inputImg[CONV(x+i,y+j,width)].g;
            pBuffer[CONV(i,j,w)].b = inputImg[CONV(x+i,y+j,width)].b;
        }
    }

    y += w - 2*overlapSize;

    return result;
}





int blurOneIter(simpleImage* inputImg, int size, int threshold)
{
    int end = 1;

    int width = inputImg->width;
    int height = inputImg->height;

    pixel* p = inputImg->p;
    pixel* new = (pixel*)malloc(height * width * sizeof(pixel));

    int x,y,i,j;

    // blur image
    for(x = size; x < height - size; x++)
    {
	for(y = size; y < width - size; y++)
	{
	    int tR = 0;
	    int tG = 0;
	    int tB = 0;

	    for(i = -size; i <= size; i++)
	    {
		for(j = - size; j <= size; j++)
		{
		    tR += p[CONV(x+i,y+j,width)].r;
		    tG += p[CONV(x+i,y+j,width)].g;
		    tB += p[CONV(x+i,y+j,width)].b;
		}
	    }

	    new[CONV(x,y,width)].r = tR / ((2*size+1)*(2*size+1));
	    new[CONV(x,y,width)].g = tG / ((2*size+1)*(2*size+1));
	    new[CONV(x,y,width)].b = tB / ((2*size+1)*(2*size+1));
	}
    }

    for(x = size; x < height-size; x++)
    {
	for(y = size; y < width-size; y++)
	{
	    float diffR, diffG, diffB;

	    diffR = new[CONV(x,y,width)].r - p[CONV(x,y,width)].r;
	    diffG = new[CONV(x,y,width)].g - p[CONV(x,y,width)].g;
	    diffB = new[CONV(x,y,width)].b - p[CONV(x,y,width)].b;

	    if(
		diffR > threshold || -diffR > threshold
		||
		diffG > threshold || -diffG > threshold
		||
		diffB > threshold || -diffB > threshold
		)
	    {
		end = 0;
	    }

	    p[CONV(x,y,width)].r = new[CONV(x,y,width)].r;
	    p[CONV(x,y,width)].g = new[CONV(x,y,width)].g;
	    p[CONV(x,y,width)].b = new[CONV(x,y,width)].b;
	}
    }

    free(new);

    return end;
}



void slaveBlur(int size, int threshold)
{
    int idImg = 0; // id of the received image
    int sizePixels = 0; // size of the pixels array
    int blurEnd = 0; // end of blur ?
    simpleImage myImg; // image received
    myImg.p = NULL;

    MPI_Status s;

    while(true)
    {

	// get simpleImage
	MPI_Recv(&myImg, sizeof(simpleImage), MPI_BYTE, ROOT, MPI_ANY_TAG, MPI_COMM_WORLD, &s);
	
	idImg = s.MPI_TAG;
	if(idImg == 0)
	{
	    // end of work
	    break;
	}

	sizePixels = myImg.width * myImg.height * sizeof(pixel);
	myImg.p = malloc(sizePixels);
	if(myImg.p == NULL)
	{
	    fprintf(stderr, "Error of allocation\n");

#ifdef DEV_DEBUG
	    fprintf(stderr, "Abort on line %d\n\n", __LINE__);
#endif

	    fflush(stderr);
	    MPI_Abort(MPI_COMM_WORLD,1);
	}

	MPI_Recv(myImg.p, sizePixels, MPI_BYTE, ROOT, idImg, MPI_COMM_WORLD, NULL);
	// simpleImage got

        /**************************************************/

	// apply blur
	blurEnd = blurOneIter(&myImg, size, threshold);


        /**************************************************/
	// send simpleImage
	MPI_Send(&myImg, sizeof(simpleImage), MPI_BYTE, ROOT, idImg, MPI_COMM_WORLD);
	MPI_Send(myImg.p, sizePixels, MPI_BYTE, ROOT, idImg, MPI_COMM_WORLD);
	MPI_Send(&blurEnd, 1, MPI_INT, ROOT, idImg, MPI_COMM_WORLD);
	// simpleImage sent
	

	free(myImg.p);
	myImg.p = NULL;
    }

}


void mergeSubImg(pixel* result, int width, int height, simpleImage bluredImg, int size)
{
    int x, y;
    pixel* p = bluredImg.p;

    for(x = size; x < bluredImg.height - size; x++)
    {
	for(y = size; y < bluredImg.width - size; y++)
	{
	    result[CONV(x+bluredImg.offsetX, y+bluredImg.offsetY, width)].r = p[CONV(x,y,bluredImg.width)].r;
	    result[CONV(x+bluredImg.offsetX, y+bluredImg.offsetY, width)].g = p[CONV(x,y,bluredImg.width)].g;
	    result[CONV(x+bluredImg.offsetX, y+bluredImg.offsetY, width)].b = p[CONV(x,y,bluredImg.width)].b;
	}
    } 
}


void masterBlurOnePart(pixel* inputImg, int width, int height, int size, int threshold, int nbTasks)
{// TODO
    int end;
    int iTask; // next slave
    int idImg; // id of subImg
    int nbToWait; // nb of image to wait

    int refSize = (int)(COEF_REFSIZE * size);
    int sizePixels;
    
    simpleImage* subImg = NULL;

    pixel* resultImg = NULL;
    resultImg = (pixel*)malloc(width * height * sizeof(pixel));
    if(resultImg == NULL)
    {
	fprintf(stderr, "Error of allocation\n");

#ifdef DEV_DEBUG
	fprintf(stderr, "Abort on line %d\n\n", __LINE__);
#endif
	fflush(stderr);
	MPI_Abort(MPI_COMM_WORLD, 1);
    }


    pixel* pBuffer = NULL;
    pBuffer = (pixel*)malloc(width * height * sizeof(pixel));
    if(pBuffer == NULL)
    {
	fprintf(stderr, "Error of allocation\n");

#ifdef DEV_DEBUG
	fprintf(stderr, "Abort on line %d\n\n", __LINE__);
#endif
	fflush(stderr);
	MPI_Abort(MPI_COMM_WORLD, 1);
    }

    // blur
    do
    {
	end = 1;
	iTask = 0;
	idImg = 1;
	nbToWait = 0;

	// send one part to each slave
	while(iTask < nbTasks)
	{
	    if(iTask == ROOT)
	    {
		iTask++;
		continue;
	    }
	    
	    subImg = getNextSubImg(inputImg, width, height, size, refSize, (idImg == 1), pBuffer);

	    if(subImg == NULL)
	    {
		// all subImg sent
		break;
	    }

            /**************************************************/

	    // send simpleImage
	    MPI_Send(subImg, sizeof(simpleImage), MPI_BYTE, iTask, idImg, MPI_COMM_WORLD);
	    sizePixels = subImg->width * subImg->height * sizeof(pixel);
	    MPI_Send(subImg->p, sizePixels, MPI_BYTE, iTask, idImg, MPI_COMM_WORLD);
	    // simpelImage sent

            /**************************************************/

	    free(subImg);
	    subImg = NULL;

	    iTask++;
	    idImg++;
	    nbToWait++;
	}

	// wait for slaves
	simpleImage recvImg;
	MPI_Status s;
	int slaveEnd;
	int recvIdImg;
	while(nbToWait > 0)
	{
	    // receive simpleImage
	    MPI_Recv(&recvImg, sizeof(simpleImage), MPI_BYTE, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &s);
	    recvImg.p = pBuffer;
	    sizePixels = recvImg.width * recvImg.height * sizeof(pixel);
	    iTask = s.MPI_SOURCE;
	    recvIdImg = s.MPI_TAG;
	    MPI_Recv(recvImg.p, sizePixels, MPI_BYTE, iTask, recvIdImg, MPI_COMM_WORLD, NULL);
	    MPI_Recv(&slaveEnd, 1, MPI_INT, iTask, recvIdImg, MPI_COMM_WORLD, NULL);
	    
	    end = end && slaveEnd;

	    nbToWait--;

	    mergeSubImg(resultImg, width, height, recvImg, size);

	    /**************************************************/

	    // send new subimage
	    subImg = getNextSubImg(inputImg, width, height, size, refSize, (idImg == 1), pBuffer);

	    if(subImg != NULL)
	    {
		// send simpleImage
		MPI_Send(subImg, sizeof(simpleImage), MPI_BYTE, iTask, idImg, MPI_COMM_WORLD);
		sizePixels = subImg->width * subImg->height * sizeof(pixel);
		MPI_Send(subImg->p, sizePixels, MPI_BYTE, iTask, idImg, MPI_COMM_WORLD);
		// simpelImage sent

		nbToWait++;
		idImg++;

		free(subImg);
	    }
	}


	// copy resultImg in inputImg
	int x, y;
	for(x=0; x < height; x++)
	{
	    for(y=0; y < width; y++)
	    {
		inputImg[CONV(x,y,width)].r = resultImg[CONV(x,y,width)].r;
		inputImg[CONV(x,y,width)].g = resultImg[CONV(x,y,width)].g;
		inputImg[CONV(x,y,width)].b = resultImg[CONV(x,y,width)].b;
	    }
	}

    }while(threshold > 0 && !end);

    free(pBuffer);
    free(resultImg);
}

void masterBlur(animated_gif* image, int size, int threshold, int nbTasks)
{
    if(nbTasks < 2)
    {
	fprintf(stderr, "Not enough tasks: masterBlur function needs at least 2 tasks\n");
	
#ifdef DEV_DEBUG
	fprintf(stderr, "Abort on line %d\n\n", __LINE__);
#endif
	fflush(stderr);
	MPI_Abort(MPI_COMM_WORLD, 1);
    }

    int i;
    int width, height;

    pixel* input = NULL;

    // process all images
    for(i = 0; i < image->n_images; i++) // TODO: unify the blur of 2 parts
    {
	width = image->width[i];
	height = image->height[i];

	input = image->p[i];
	
        // blur top
	masterBlurOnePart(input, width, height/10, size, threshold, nbTasks);

	// blur bottom
	masterBlurOnePart(input+(CONV((int)(height*0.9),0,width)), width, height/10, size, threshold, nbTasks);
	
    }

    killSlaves(nbTasks);

}
