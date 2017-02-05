/**************************************************/
/* try a static distribution for the blur filter  */
/**************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <mpi.h>

#include "parallelBlur.h"

#define PARALLEL_DEBUG 1
#define ROOT 0

#define MAX(a,b) (a > b) ? (a) : (b)
#define MIN(a,b) (a < b) ? (a) : (b)

// return the number of parts of the inputImage
// destTopOffset[i] give the limit of the 10%
int splitImage(int inputWidth, int inputHeight, int* heightOffset, int* widthOffset, int* destTopOffset, int* destBottomOffset, int* subWidth, int* subHeight, int overlapSize)
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

    int width = inputWidth;
    int height = inputHeight;

    int topOffset = height/10 - size;
    int bottomOffset = height*0.9 + size;

    int nbWidth = width / (*subWidth);
    if(width % (*subWidth) > 0)
	nbWidth++;

    int nbHeight = height / (*subHeight);
    if(height % (*subHeight) > 0)
	nbHeight++;

    int resultNb = nbHeight * nbWidth;

    heightOffset = malloc(2*resultNb * sizeof(int));
    widthOffset = malloc(2*resultNb * sizeof(int));
    destTopOffset = malloc(resultNb * sizeof(int));
    destBottomOffset = malloc(resultNb * sizeof(int));
    
    int x,y;
    int index = 0;
    for(x = 0; x < nbHeight; x++)
    {
	for(y = 0; y < nbWidth; y++)
	{
	    heightOffset[2*index] = MAX(x * (*subHeight) - size, 0);
	    heightOffset[2*index+1] = MIN((x + 1) * (*subHeight) + size ,height);

	    widthOffset[2*index] = MAX(y * (*subWidth) - size, 0);
	    widthOffset[2*index+1] = MIN((y + 1) * (*subWidth) + size, width);

	    destTopOffset[index] = topOffset - heightOffset[2*index]; // nb of lines in the top 10% (if positive)
	    destBottomOffset[index] = heightOffset[2*index+1] - bottomOffset; // nb of lines in the bottom 10% (if positive)
	}
    }
    

    return resultNb;
}

// destImg must exist and contains a simpleImage
int getSubImage(animated_gif* inputImage, int numImg, simpleImage* destImg, int* heightOffset, int* widthOffset, int myNum)
{
    #if PARALLEL_DEBUG
    fprintf(stderr, "--> test 1\n");
    #endif

    int i = myNum;
    
    int inWidth = inputImage->width[numImg];
    pixel* iP = inputImage->p[numImg];

    pixel* outP = destImg->p;
    
    int hOBegin = heightOffset[2*i];
    int hOEnd = heightOffset[2*i+1];
    
    int wOBegin = widthOffset[2*i];
    int wOEnd = widthOffset[2*i+1];
    
    int destWidth = wOEnd - wOEnd;
    destImg->height = hOEnd - hOBegin;
    destImg->width = destWidth;

    #if PARALLEL_DEBUG
    fprintf(stderr, "--> test 2\n");
    #endif

    int x,y;
    for(x = hOBegin; x < hOEnd; x++)
    {
	for(y = wOBegin; y < wOEnd; y++)
	{
	    outP[CONV(x-hOBegin,y-wOBegin,destWidth)].r = iP[CONV(x,y,inWidth)].r;
	    outP[CONV(x-hOBegin,y-wOBegin,destWidth)].g = iP[CONV(x,y,inWidth)].g;
	    outP[CONV(x-hOBegin,y-wOBegin,destWidth)].b = iP[CONV(x,y,inWidth)].b;
	}
    }
    
    #if PARALLEL_DEBUG
    fprintf(stderr, "--> test 3\n");
    #endif
    
    return 0;
}


// destImgArray must be created before call
int fillSubImagesArray(animated_gif* inputImage, int numImg, simpleImage* destImgArray, int* heightOffset, int* widthOffset, int nbSubImg)
{
        #if PARALLEL_DEBUG
    fprintf(stderr, "-> fill %d subImg\n", nbSubImg);
        #endif

    int i;
    for(i = 0; i < nbSubImg; i++)
    {
	#if PARALLEL_DEBUG
	fprintf(stderr, "-> just before getSubImage %d\n", i);
        #endif
	getSubImage(inputImage, numImg, destImgArray + i, heightOffset, widthOffset, i);
    }

    
#if PARALLEL_DEBUG
    fprintf(stderr, "-> end fill %d subImg\n", nbSubImg);
        #endif

    return 0;
}

int mergeSubImg(pixel* new, int width, pixel* p, int hOBegin, int hOEnd, int wOBegin, int wOEnd, int size)
{
    int subWidth = wOEnd-wOBegin;

    int x,y;
    for(x = hOBegin+size; x < hOEnd-size; x++)
    {
	for(y = wOBegin+size; y < wOEnd-size; y++)
	{
	    new[CONV(x,y,width)].r = p[CONV(x,y,subWidth)].r;
	    new[CONV(x,y,width)].g = p[CONV(x,y,subWidth)].g;
	    new[CONV(x,y,width)].b = p[CONV(x,y,subWidth)].b;
	}
    }

    return 0;
}


// topOffset = (if positive) nb of lines in the top 10%
// bottomOffset = (if positive) nb of lines in the bottom 10%
// return 0 if not stable
int one_iter_blur_filter(simpleImage* image, int size, int threshold, int topOffset, int bottomOffset)
{
    int width = image->width;
    int height = image->height;

    int topLimit = MAX(size, topOffset-size);
    int bottomLimit = MIN(height-size, height - bottomOffset+size);

    pixel* p = image->p;
    pixel* new = (pixel*)malloc(width*height*sizeof(pixel));

    int end = 1;
    
    int j,k;

    /* Apply blur on top part of image (10%) */
    for(j=size; j<topLimit; j++)
    {
        for(k=size; k<width-size; k++)
        {
            int stencil_j, stencil_k ;
            int t_r = 0 ;
            int t_g = 0 ;
            int t_b = 0 ;

            for ( stencil_j = -size ; stencil_j <= size ; stencil_j++ )
            {
                for ( stencil_k = -size ; stencil_k <= size ; stencil_k++ )
                {
                    t_r += p[CONV(j+stencil_j,k+stencil_k,width)].r ;
                    t_g += p[CONV(j+stencil_j,k+stencil_k,width)].g ;
                    t_b += p[CONV(j+stencil_j,k+stencil_k,width)].b ;
                }
            }

            new[CONV(j,k,width)].r = t_r / ( (2*size+1)*(2*size+1) ) ;
            new[CONV(j,k,width)].g = t_g / ( (2*size+1)*(2*size+1) ) ;
            new[CONV(j,k,width)].b = t_b / ( (2*size+1)*(2*size+1) ) ;
        }
    }

    /* Copy the middle part of the image */
    for(j=topLimit; j<bottomLimit; j++)
    {
        for(k=size; k<width-size; k++)
        {
            new[CONV(j,k,width)].r = p[CONV(j,k,width)].r ; 
            new[CONV(j,k,width)].g = p[CONV(j,k,width)].g ; 
            new[CONV(j,k,width)].b = p[CONV(j,k,width)].b ; 
        }
    }

    /* Apply blur on the bottom part of the image (10%) */
    for(j=bottomLimit; j<height-size; j++)
    {
        for(k=size; k<width-size; k++)
        {
            int stencil_j, stencil_k ;
            int t_r = 0 ;
            int t_g = 0 ;
            int t_b = 0 ;

            for ( stencil_j = -size ; stencil_j <= size ; stencil_j++ )
            {
                for ( stencil_k = -size ; stencil_k <= size ; stencil_k++ )
                {
                    t_r += p[CONV(j+stencil_j,k+stencil_k,width)].r ;
                    t_g += p[CONV(j+stencil_j,k+stencil_k,width)].g ;
                    t_b += p[CONV(j+stencil_j,k+stencil_k,width)].b ;
                }
            }

            new[CONV(j,k,width)].r = t_r / ( (2*size+1)*(2*size+1) ) ;
            new[CONV(j,k,width)].g = t_g / ( (2*size+1)*(2*size+1) ) ;
            new[CONV(j,k,width)].b = t_b / ( (2*size+1)*(2*size+1) ) ;
        }
    }


    
    for(j=1; j<height-1; j++)
    {
        for(k=1; k<width-1; k++)
        {

            float diff_r ;
            float diff_g ;
            float diff_b ;

            diff_r = (new[CONV(j  ,k  ,width)].r - p[CONV(j  ,k  ,width)].r) ;
            diff_g = (new[CONV(j  ,k  ,width)].g - p[CONV(j  ,k  ,width)].g) ;
            diff_b = (new[CONV(j  ,k  ,width)].b - p[CONV(j  ,k  ,width)].b) ;

            if ( diff_r > threshold || -diff_r > threshold 
                 ||
                 diff_g > threshold || -diff_g > threshold
                 ||
                 diff_b > threshold || -diff_b > threshold
                ) {
                end = 0 ;
            }

            p[CONV(j  ,k  ,width)].r = new[CONV(j  ,k  ,width)].r ;
            p[CONV(j  ,k  ,width)].g = new[CONV(j  ,k  ,width)].g ;
            p[CONV(j  ,k  ,width)].b = new[CONV(j  ,k  ,width)].b ;
        }
    }

    free(new);
    
    return end;
}



void apply_blur_filter_dynamic(animated_gif* img, int size, int threshold)
{
    int nbTasks, myRank;
    MPI_Comm_size(MPI_COMM_WORLD, &nbTasks);
    MPI_Comm_rank(MPI_COMM_WORLD, &myRank);

    #if PARALLEL_DEBUG
    fprintf(stderr, "%d : begin blur filter\n", myRank);
    #endif
    
    
    int sizeMaxPixels = 0;
    int i;
    for(i=0; i < img->n_images; i++)
    {
	int v = img->width[i] * img->height[i];
	if(v > sizeMaxPixels)
	    sizeMaxPixels = v;
    }
    sizeMaxPixels *= sizeof(pixel);

    if(myRank == 0)
    {
	if(nbTasks < 2)
	{
	    exit(1);
	}

	pixel** p = img->p;
	pixel* new;
	int i;
	for(i=0; i < img->n_images; i++)
	{
            #if PARALLEL_DEBUG
            fprintf(stderr, "%d : blur img %d\n", myRank, i);
            #endif
            
	    int* heightOffset;
	    int* widthOffset;
	    int* topOffset;
	    int* bottomOffset;
	    
	    int subWidth = 3*size;
	    int subHeight = 3*size;
	    
	    // get informations for subimages (can resize subWidth and subHeight)
            #if PARALLEL_DEBUG
            fprintf(stderr, "%d : just before split img %d\n", myRank, i);
            #endif
	    int nbSubImg = splitImage(img->width[i], img->height[i], heightOffset, widthOffset, topOffset, bottomOffset, &subWidth, &subHeight, size);
            #if PARALLEL_DEBUG
            fprintf(stderr, "%d : just after split img %d\n", myRank, i);
            #endif

            
	    simpleImage* imgArray;
	    imgArray = (simpleImage*)malloc(nbSubImg * sizeof(simpleImage));
	    
	    pixel* recvPixels;
	    recvPixels = malloc(sizeMaxPixels);

	    int end = 0;
	    do
	    {

		#if PARALLEL_DEBUG
		fprintf(stderr, "%d : just before fillSubImagesArray\n", myRank);
                #endif
		fillSubImagesArray(img, i, imgArray, heightOffset, widthOffset, nbSubImg);
		#if PARALLEL_DEBUG
		fprintf(stderr, "%d : just after fillSubImagesArray\n", myRank);
                #endif

		end = 1;

		int iImg;
		int iTask;
		int nbImgRecv = 0;
		MPI_Status s;
		
		int* bufSend; // [width, height, topOffset, bottomOffset, pixelsSize]
		int bufSendSize = 4;
		bufSend = malloc(bufSendSize*sizeof(int));

		iImg = 0;
		iTask = 1;
		// send a subImg to each slave
		#if PARALLEL_DEBUG
		fprintf(stderr, "%d : just before send to each slave\n", myRank);
                #endif
		while(iImg < nbSubImg && iTask < nbTasks)
		{
		    bufSend[0] = imgArray[iImg].width;
		    bufSend[1] = imgArray[iImg].height;
		    bufSend[2] = topOffset[iImg];
		    bufSend[3] = bottomOffset[iImg];

		    MPI_Send(bufSend, bufSendSize, MPI_INT, iTask, iImg, MPI_COMM_WORLD);
		    int sizeRecvBuf = bufSend[0]*bufSend[1]*sizeof(pixel);
		    MPI_Send(imgArray[iImg].p, sizeRecvBuf, MPI_BYTE, iTask, iImg, MPI_COMM_WORLD);

		    iImg++;
		    iTask++;
		}

		#if PARALLEL_DEBUG
		fprintf(stderr, "%d : just after send to each slave\n", myRank);
                #endif


		for(; iImg < nbSubImg; i++)
		{
		    MPI_Recv(recvPixels, sizeMaxPixels, MPI_BYTE, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &s);

		    iTask = s.MPI_SOURCE;
		    int iSubImg = 2*s.MPI_TAG;
			
		    mergeSubImg(
			p[i], img->width[i], recvPixels,
			heightOffset[iSubImg], heightOffset[iSubImg+1],
			widthOffset[iSubImg], widthOffset[iSubImg+1],
			size
			);
		    
		    nbImgRecv++;
		    
		    int subEnd;
		    MPI_Recv(&subEnd, 1, MPI_INT, iTask, s.MPI_TAG, MPI_COMM_WORLD, NULL);
		    
		    end = end && subEnd;
		    

		    bufSend[0] = imgArray[iImg].width;
		    bufSend[1] = imgArray[iImg].height;
		    bufSend[2] = topOffset[iImg];
		    bufSend[3] = bottomOffset[iImg];

		    MPI_Send(bufSend, bufSendSize, MPI_INT, iTask, 0, MPI_COMM_WORLD);
		    int sizeRecvBuf = bufSend[0]*bufSend[1]*sizeof(pixel);
		    MPI_Send(imgArray[iImg].p, sizeRecvBuf, MPI_BYTE, iTask, iImg, MPI_COMM_WORLD);
		}

		for(iImg = nbImgRecv; iImg < nbSubImg; i++)
		{
		    MPI_Recv(recvPixels, sizeMaxPixels, MPI_BYTE, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &s);

		    int task = s.MPI_SOURCE;

		    int iSubImg = 2*s.MPI_TAG;
			
		    mergeSubImg(
			p[i], img->width[i], recvPixels,
			heightOffset[iSubImg], heightOffset[iSubImg+1],
			widthOffset[iSubImg], widthOffset[iSubImg+1],
			size
			);

		    int subEnd;
		    MPI_Recv(&subEnd, 1, MPI_INT, task, 0, MPI_COMM_WORLD, NULL);
		    
		    end = end && subEnd;
		}


		free(bufSend);
		

	    }while(threshold > 0 && !end);

	    free(recvPixels);
	    free(imgArray);
	}

	// kill each slave
	int iTask;
	for(iTask = 1; iTask < nbTasks; iTask++)
	{
	    MPI_Send(NULL, 0, MPI_INT, iTask, 0, MPI_COMM_WORLD);
	}

    }
    else
    {
        #if PARALLEL_DEBUG
        fprintf(stderr, "%d : begin slave part\n", myRank);
        #endif
        
	int endBlur = 0;

	int* whtbBuf;
	whtbBuf = malloc(4*sizeof(int));
	simpleImage subImg;
	subImg.p = malloc(sizeMaxPixels);
	int iSubImg;
	MPI_Status s;
	int count = 0;
	do
	{
            #if PARALLEL_DEBUG
            fprintf(stderr, "slave %d : wait for a msg\n", myRank);
            #endif
            
	    MPI_Recv(whtbBuf, 4, MPI_INT, 0, 0, MPI_COMM_WORLD, &s);
	    MPI_Get_count(&s, MPI_INT, &count);
	    if(count < 1)
	    {
		// end of work as slave
		break;
	    }

	    subImg.width = whtbBuf[0];
	    subImg.height = whtbBuf[1];

	    MPI_Recv(subImg.p, whtbBuf[0]*whtbBuf[1]*sizeof(pixel), MPI_BYTE, 0, MPI_ANY_TAG, MPI_COMM_WORLD, &s);
	    iSubImg = s.MPI_TAG;

	    endBlur = one_iter_blur_filter(&subImg, size, threshold, whtbBuf[2], whtbBuf[3]);

	    MPI_Send(subImg.p, whtbBuf[0]*whtbBuf[1]*sizeof(pixel), MPI_BYTE, 0, iSubImg, MPI_COMM_WORLD);
	    MPI_Send(&endBlur, 1, MPI_INT, 0, iSubImg, MPI_COMM_WORLD);
	} while(true);
	    
	free(whtbBuf);
	free(subImg.p);
    }
}


int main_parallel_blur(int argc, char** argv)
{
    MPI_Init(&argc, &argv);

    int nbTasks, myRank;
    MPI_Comm_size(MPI_COMM_WORLD, &nbTasks);
    MPI_Comm_rank(MPI_COMM_WORLD, &myRank);

    char * input_filename ; 
    char * output_filename ;
    animated_gif * image ;
    struct timeval t1, t2;
    double duration ;

    if ( argc < 3 )
    {
        fprintf( stderr, "Usage: %s input.gif output.gif \n", argv[0] ) ;
        return 1 ;
    }

    input_filename = argv[1] ;
    output_filename = argv[2] ;

    if(myRank == ROOT)
    {
        /* IMPORT Timer start */
        gettimeofday(&t1, NULL);
        
        /* Load file and store the pixels in array */
        image = load_pixels( input_filename ) ;
        if ( image == NULL ) { return 1 ; }
        
        /* IMPORT Timer stop */
        gettimeofday(&t2, NULL);
        
        duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);
        
        printf( "GIF loaded from file %s with %d image(s) in %lf s\n", 
                input_filename, image->n_images, duration ) ;
        
        /* FILTER Timer start */
        gettimeofday(&t1, NULL);

        /* Convert the pixels into grayscale */
        apply_gray_filter( image ) ;

        /* Apply blur filter with convergence value */
        //apply_blur_filter( image, 5, 20 ) ; // TO BE REPLACED

        #if PARALLEL_DEBUG
        fprintf(stderr, "%d : just before blur\n", myRank);
        #endif
        
        apply_blur_filter_dynamic(image, 5, 20);

        #if PARALLEL_DEBUG
        fprintf(stderr, "%d : just after blur\n", myRank);
        #endif
        
        /* Apply sobel filter on pixels */
        apply_sobel_filter( image ) ;
        
        /* FILTER Timer stop */
        gettimeofday(&t2, NULL);
        
        duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);
        
        printf( "SOBEL done in %lf s\n", duration ) ;
        
        /* EXPORT Timer start */
        gettimeofday(&t1, NULL);
        
        /* Store file from array of pixels to GIF file */
        if ( !store_pixels( output_filename, image ) ) { return 1 ; }
        
        /* EXPORT Timer stop */
        gettimeofday(&t2, NULL);
        
        duration = (t2.tv_sec -t1.tv_sec)+((t2.tv_usec-t1.tv_usec)/1e6);
        
        printf( "Export done in %lf s in file %s\n", duration, output_filename ) ;
    }
    else // not root
    {
        image = (animated_gif*)load_pixels( input_filename ) ;
        if ( image == NULL ) { return 1 ; }

        #if PARALLEL_DEBUG
        fprintf(stderr, "%d : just before blur\n", myRank);
        #endif
        
        apply_blur_filter_dynamic(image, 5, 20);

        #if PARALLEL_DEBUG
        fprintf(stderr, "%d : just after blur\n", myRank);
        #endif
    }
    
    MPI_Finalize();

    return 0;
}
