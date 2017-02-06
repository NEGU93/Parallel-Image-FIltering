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
    result->height = h;
    result->width = w;
    result->p = pBuffer;

    printf("DEBUG: (x,y) = (%d,%d) | (h,w) = (%d,%d)\n", x, y, h, w);

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

    for(x = 1; x < height-1; x++)
    {
	for(y = 1; y < width-1; y++)
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
    int idImg = 0;
    int sizePixels = 0;
    int blurEnd = 0;
    simpleImage myImg;
    myImg.p = NULL;

    int* dimBuf = (int*)malloc(2 * sizeof(int)); // [width, height]
    MPI_Status s;

    while(true)
    {
	MPI_Recv(dimBuf, 2, MPI_INT, ROOT, MPI_ANY_TAG, MPI_COMM_WORLD, &s);

	// get id of image
	idImg = s.MPI_TAG;

	if(idImg < 0)
	{
	    // end of work
	    break;
	}

	// get dimensions
	myImg.width = dimBuf[0];
	myImg.height = dimBuf[1];

	// create pixels array
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

	// get image
	MPI_Recv(myImg.p,  sizePixels, MPI_BYTE, ROOT, idImg, MPI_COMM_WORLD, &s);

	// apply blur
	blurEnd = blurOneIter(&myImg, size, threshold);

	// send to root
	// image
	MPI_Send(myImg.p, sizePixels, MPI_BYTE, ROOT, idImg, MPI_COMM_WORLD);
	// blur end
	MPI_Send(&blurEnd, 1, MPI_INT, ROOT, idImg, MPI_COMM_WORLD);

	free(myImg.p);
	myImg.p = NULL;
    }

    free(dimBuf);
}


void masterBlurOnePart(pixel* inputImg, int width, int height, int size, int threshold, int nbTasks)
{
    int end; // TODO
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

    int refSize = COEF_REFSIZE * size;

    int i;
    int idSubImg, iTask;
    int end;
    int width, height;

    int* dimBuf = (int*)malloc(2 * sizeof(int)); // [width, height] of subimage
    pixel* pBuffer = NULL;
    pixel* input = NULL;
    pixel* new = NULL;
    simpleImage* subImg = NULL;

    // process all images
    for(i = 0; i < image->n_images; i++)
    {
	end = 1;
	width = image->width[i];
	height = image->height[i];

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

	input = image->p[i];
	
        // blur top
	do
	{
	    idSubImg = 0;
	    // one subimg to each slave
	    iTask = 1;
	    do
	    {
		
		subImg = getNextSubImg(input, width, height/10, size, refSize, (idSubImg == 0), pBuffer);
		idSubImg++;
		
		if(subImg->p == NULL)
		{
		    break;
		}
		
		dimBuf[0] = subImg->width;
		dimBuf[1] = subImg->height;
		int sizePBuf = dimBuf[0] * dimBuf[1] * sizeof(pixel);

		MPI_Send(dimBuf, 2, MPI_INT, iTask, idSubImg, MPI_COMM_WORLD);
		MPI_Send(pBuffer, sizePBuf, MPI_BYTE, iTask, idSubImg, MPI_COMM_WORLD);
		
		iTask++;
	    }while(iTask < nbTasks);

	    // send rest of subImg
	    while(subImg->p != NULL)
	    {

	    }
	    
	} while(!end);
	
	free(pBuffer);
	pBuffer = NULL;
	
    }

    free(dimBuf);
    free(new);
    free(subImg);
}
