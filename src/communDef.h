#ifndef DEF_COMMUN_DEF
#define DEF_COMMUN_DEF

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/time.h>

#include <gif_lib.h>

#define ROOT 0
#define SOBELF_DEBUG 0

#define OVERLAPSIZE 5
#define THRESHOLD 20

#define CONV(l,c,nb_c) (l)*(nb_c)+(c)

#define MAX(a,b) ((a > b) ? (a) : (b))
#define MIN(a,b) ((a < b) ? (a) : (b))

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
    int offsetX; /* offset height top left corner */
    int offsetY; /* offset width top left corner */
    int width;  /* width of the image */
    int height; /* height of the image */
    pixel* p;   /* pixels of the image*/
} simpleImage;

#endif
