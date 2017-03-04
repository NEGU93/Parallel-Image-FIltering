#include "parallelSplitMPI.h"

int mainParallelSplitMPI(int argc, char** argv)
{
    printf("Test1\n");
    MPI_Init(&argc, &argv);
    printf("Test2\n");

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

    return 0; // DEBUG

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
    blurFilter(image, OVERLAPSIZE, THRESHOLD);

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

    MPI_Finalize();

    return 0;
}


// size of N tiles in h*w
void getTileSize(int h, int w, int N, int* size)
{
    int nbX = (int)sqrt(N * w / h);
    int nbY = N / nbX;

    size[0] = h / nbX;
    size[1] = w / nbY;
}

int getPartBlur(int height, int width, int size, int myRank, int nbTasks, int* output, int* rank2dim, int* groupDim)
{
    int groupSize = nbTasks / 2; // one on top and one on bottom

    int stripeHeight = height / 10 - size;
    int stripeWidth = width - (2 * size);

    int tileSize[2];
    getTileSize(stripeHeight, stripeWidth, groupSize, tileSize);

    int nbX = stripeHeight / tileSize[0];
    int nbY = stripeWidth / tileSize[1];
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

void writeImg(pixel* input, pixel* output, int inputWidth, int offsetX, int offsetY, int height, int width)
{
    int i,j;

    for(i = 0; i < height; i++)
    {
        for(j = 0; j < width; j++)
        {
            output[CONV(offsetX + i, offsetY + j, width)].r = input[CONV(i, j, inputWidth)].r;
            output[CONV(offsetX + i, offsetY + j, width)].g = input[CONV(i, j, inputWidth)].g;
            output[CONV(offsetX + i, offsetY + j, width)].b = input[CONV(i, j, inputWidth)].b;
        }
    }
}

void send(pixel* input, int inputWidth, int offsetX, int offsetY, int height, int width, int targetRank)
{
    pixel* buffer;
    int size = height * width * sizeof(pixel);
    buffer = (pixel*)malloc(size);

    // fill buffer
    copyImg(input, buffer, inputWidth, offsetX, offsetY, height, width);

    // send to targetRank
    MPI_Send(buffer, size, MPI_BYTE, targetRank, 0, MPI_COMM_WORLD);

    free(buffer);
}

void recv(pixel* output, int outputWidth, int offsetX, int offsetY, int height, int width, int sourceRank)
{
    pixel* buffer;
    int size = height * width * sizeof(pixel);
    buffer = (pixel*)malloc(size);

    // recv from sourceRank
    MPI_Status s;
    MPI_Recv(buffer, size, MPI_BYTE, sourceRank, 0, MPI_COMM_WORLD, &s);

    // write in output
    writeImg(buffer, output, width, offsetX, offsetY, height, outputWidth);

    free(buffer);
}

void blurFilter(animated_gif* image, int size, int threshold)
{
    int i,j,k;
    int width, height;
    int end = 0;
    int n_iter = 0;

    pixel** p;
    pixel* new;

    int shape[4];
    int myDimRank[2];
    int myDimGroup[2];
    int myWidth;
    int myHeight;
    pixel* myImg;

    int myRank;
    int nbTasks;

    MPI_Comm_size(MPI_COMM_WORLD, &nbTasks);
    MPI_Comm_rank(MPI_COMM_WORLD, &myRank);

    p = image->p;

    for(i = 0; i < image->n_images; i++)
    {
        n_iter = 0;
        width = image->width[i];
        height = image->height[i];

        if(getPartBlur(height, width, size, myRank, nbTasks, shape, myDimRank, myDimGroup))
        {
            myHeight = shape[2] - shape[0] + 2*size;
            myWidth = shape[3] - shape[1] + 2*size;
            // allocate array of pixels (with overlaps)
            myImg = (pixel*)malloc(myHeight * myWidth * sizeof(pixel));

            // copy part of the original image (with overlaps)
            copyImg(p[i], myImg, width, shape[0] - size, shape[1] - size, myHeight, myWidth);

            // allocate array of new pixels (with unused overlaps) (* TODO: remove overlaps *)
            new = (pixel*)malloc(myHeight * myWidth * sizeof(pixel));

            do
            {
                end = 1;
                n_iter++;

                /******************************/

                // recv overlaps area from left, top left, top, top right
                if(myDimRank[0] > 0)
                {
                    if(myDimRank[1] > 0)
                    {
                        // from top left
                        recv(myImg, myWidth,
                             0, 0,
                             size, size,
                             myRank - myDimGroup[1] -1);
                    }

                    // from top
                    recv(myImg, myWidth,
                         0, size,
                         size, myWidth - 2*size,
                         myRank - myDimGroup[1]);

                    if(myDimRank[1] < myDimGroup[1] - 1)
                    {
                        // from top right
                        recv(myImg, myWidth,
                             0, myWidth - size,
                             size, size,
                             myRank - myDimGroup[1] + 1);
                    }
                }

                if(myDimRank[1] > 0)
                {
                    // from left
                    recv(myImg, myWidth,
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
                        send(myImg, myWidth,
                             size, size,
                             size, size,
                             myRank - myDimGroup[1] - 1);
                    }

                    // to top
                    send(myImg, myWidth,
                         size, size,
                         size, myWidth - 2*size,
                         myRank - myDimGroup[1]);

                    if(myDimRank[1] < myDimGroup[1] - 1)
                    {
                        // to top right
                        send(myImg, myWidth,
                             size, myWidth - 2*size,
                             size, size,
                             myRank - myDimGroup[1] + 1);
                    }
                }

                if(myDimRank[1] > 0)
                {
                    // to left
                    send(myImg, myWidth,
                         size, size,
                         myHeight - 2*size, size,
                         myRank - 1);
                }

                if(myDimRank[1] < myDimGroup[1] - 1)
                {
                    // to right
                    send(myImg, myWidth,
                         size, myWidth - 2*size,
                         myHeight - 2*size, size,
                         myRank + 1);
                }

                if(myDimRank[0] < myDimGroup[0] - 1)
                {
                    if(myDimRank[1] > 0)
                    {
                        // to bottom left
                        send(myImg, myWidth,
                             myHeight - 2*size, size,
                             size, size,
                             myRank + myDimGroup[1] - 1);
                    }

                    // to bottom
                    send(myImg, myWidth,
                         myHeight - 2*size, size,
                         size, myWidth - 2*size,
                         myRank + myDimGroup[1]);

                    if(myDimRank[1] < myDimGroup[1] - 1)
                    {
                        // to bottom right
                        send(myImg, myWidth,
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
                        recv(myImg, myWidth,
                             myHeight - size, 0,
                             size, size,
                             myRank + myDimGroup[1] -1);
                    }

                    // from bottom
                    recv(myImg, myWidth,
                         myHeight - size, size,
                         size, myWidth - 2*size,
                         myRank + myDimGroup[1]);

                    if(myDimRank[1] < myDimGroup[1] - 1)
                    {
                        // from bottom right
                        recv(myImg, myWidth,
                             myHeight - size, myWidth - size,
                             size, size,
                             myRank + myDimGroup[1] + 1);
                    }
                }

                if(myDimRank[1] < myDimGroup[1] - 1)
                {
                    // from right
                    recv(myImg, myWidth,
                         size, myWidth - size,
                         myHeight - 2*size, size,
                         myRank + 1);
                }

                /************************************************************/

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

                        new[CONV(j,k,myWidth)].r = t_r / ( (2*size+1)*(2*size+1) ) ;
                        new[CONV(j,k,myWidth)].g = t_g / ( (2*size+1)*(2*size+1) ) ;
                        new[CONV(j,k,myWidth)].b = t_b / ( (2*size+1)*(2*size+1) ) ;
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

                        diff_r = new[CONV(j,k,myWidth)].r - myImg[CONV(j,k,myWidth)].r;
                        diff_g = new[CONV(j,k,myWidth)].g - myImg[CONV(j,k,myWidth)].g;
                        diff_b = new[CONV(j,k,myWidth)].b - myImg[CONV(j,k,myWidth)].b;

                        if ( diff_r > threshold || -diff_r > threshold
                             ||
                             diff_g > threshold || -diff_g > threshold
                             ||
                             diff_b > threshold || -diff_b > threshold
                            ) {
                            end = 0 ;
                        }

                        myImg[CONV(j,k,myWidth)].r = new[CONV(j,k,myWidth)].r;
                        myImg[CONV(j,k,myWidth)].g = new[CONV(j,k,myWidth)].g;
                        myImg[CONV(j,k,myWidth)].b = new[CONV(j,k,myWidth)].b;
                    }
                }

                int endReduce;
                MPI_Allreduce(&end, &endReduce, 1, MPI_INT, MPI_LAND, MPI_COMM_WORLD);
                end = endReduce;

            } while(threshold > 0 && !end);

            free(myImg);
            free(new);
        }
        else
        {
            // no work for this task
            do
            {
                end = 1;
                int endReduce;
                MPI_Allreduce(&end, &endReduce, 1, MPI_INT, MPI_LAND, MPI_COMM_WORLD);
                end = endReduce;
            } while(threshold > 0 && !end);
        }
    }
}
