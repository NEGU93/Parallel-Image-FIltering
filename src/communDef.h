#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/time.h>

#include <gif_lib.h>

#define SOBELF_DEBUG 0

/* Represent one pixel from the image */
typedef struct pixel
{
    int r ; /* Red */
    int g ; /* Green */
    int b ; /* Blue */
} pixel ;

/* Represent one GIF image (animated or not */
typedef struct animated_gif
{
    int n_images ; /* Number of images */
    int * width ; /* Width of each image */
    int * height ; /* Height of each image */
    pixel ** p ; /* Pixels of each image */
    GifFileType * g ; /* Internal representation.
                         DO NOT MODIFY */
} animated_gif ;


typedef struct simpleImage  // added by Francois
{
    int width;  /* width of the image */
    int height; /* height of the image */
    pixel* p;   /* pixels of the image*/
} simpleImage;
