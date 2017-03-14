/*
 * INF560
 *
 * Image Filtering Project
 */

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <math.h>
#ifdef _WIN32
#include <windows.h>					// for Windows APIs
#include "device_launch_parameters.h"	// For VS to recognize the blockIdx
#else
#include <sys/time.h>
#endif

#include <cuPrintf.cu>
#include "gif_lib.h"

#include <cuda_runtime.h>
#include <cuda.h>

#define SOBELF_DEBUG 0

#define CONV(l,c,nb_c) \
    (l)*(nb_c)+(c)

/* Represent one pixel from the image */
typedef struct pixel {
    int r ; /* Red */
    int g ; /* Green */
    int b ; /* Blue */
} pixel ;

/* Represent one GIF image (animated or not */
typedef struct animated_gif {
    int n_images ; 		/* Number of images */
    int * width ; 		/* Width of each image */
    int * height ; 		/* Height of each image */
    pixel ** p ; 		/* Pixels of each image */
    GifFileType * g ; 	/* Internal representation.
                         DO NOT MODIFY */
} animated_gif ;

__global__ void apply_blur_top_kernel(int height, int width, int size, pixel * p, pixel * newp) {
	int j, k;
	int row = threadIdx.x;
	int	col = threadIdx.y;
	//cuPrintf("j = %d + %d < %d. j+= %d\n", row, size, height / 10 - size, blockDim.y );
	//cuPrintf("k = %d + %d < %d. k+= %d\n", col, size, width - size, blockDim.x);
	for (j = row + size; j < height / 10 - size; j += blockDim.x ) {
		for (k = col + size; k < width - size; k += blockDim.y ) {
			int stencil_j, stencil_k;
			int t_r = 0;
			int t_g = 0;
			int t_b = 0;

			for (stencil_j = -size; stencil_j <= size; stencil_j++) {
				for (stencil_k = -size; stencil_k <= size; stencil_k++) {
					t_r += p[CONV(j + stencil_j, k + stencil_k, width)].r;
					t_g += p[CONV(j + stencil_j, k + stencil_k, width)].g;
					t_b += p[CONV(j + stencil_j, k + stencil_k, width)].b;
				}
			}

			newp[CONV(j, k, width)].r = t_r / ((2 * size + 1)*(2 * size + 1));
			newp[CONV(j, k, width)].g = t_g / ((2 * size + 1)*(2 * size + 1));
			newp[CONV(j, k, width)].b = t_b / ((2 * size + 1)*(2 * size + 1));
		}
	}
}

/* Cuda inits */
void alloc_device_pixel_array(int w, int h, pixel **p) {
	cudaError_t err = cudaMalloc(p, w * h * sizeof(pixel));
	if (err != cudaSuccess) { 
		fprintf(stderr, "GPUassert: %s in function %s line %d\n", cudaGetErrorString(err), __FUNCTION__, __LINE__);
		abort(); 
	}
}
void transfer_pixel_array_H2D(int N, pixel *p, pixel *d_p) {
	cudaError_t err = cudaMemcpy(d_p, p, N * sizeof(pixel), cudaMemcpyHostToDevice);
	if (err != cudaSuccess) { 
		fprintf(stderr, "GPUassert: %s in function %s line %d\n", cudaGetErrorString(err), __FUNCTION__, __LINE__);
		abort(); 
	}
}
void transfer_pixel_array_D2H(int N, pixel *p, pixel *d_p) {
	cudaError_t err = cudaMemcpy(p, d_p, N * sizeof(pixel), cudaMemcpyDeviceToHost);
	if (err != cudaSuccess) { 
		fprintf(stderr, "GPUassert: %s in function %s line %d\n", cudaGetErrorString(err), __FUNCTION__, __LINE__);
		abort(); 
	}
}
void apply_blur_top(int height, int width, int size, pixel * p, pixel * newp) {
	pixel * d_p;
	pixel * d_new;
	dim3 gridDim(1);
	dim3 blockDim(8, 8);
	/* Alloc everything in device */
	alloc_device_pixel_array(width, height, &d_p);
	alloc_device_pixel_array(width, height, &d_new);
	/* Copy to memory */
	transfer_pixel_array_H2D(width*height, p, d_p);
	/* Call Kernel */
	//cudaPrintfInit();
	apply_blur_top_kernel<<<gridDim, blockDim>>>(height, width, size, d_p, d_new);
	//cudaPrintfDisplay(stdout, true);
    //cudaPrintfEnd();
	/* Copy the result */
	transfer_pixel_array_D2H(width*height, newp, d_new);
	/* Free everything in the device */
	cudaFree(d_p);
	cudaFree(d_new);
}
/*
 * Load a GIF image from a file and return a
 * structure of type animated_gif.
 */
animated_gif * load_pixels( char * filename ) {
    GifFileType * g ;
    ColorMapObject * colmap ;
    int error ;
    int n_images ;
    int * width ;
    int * height ;
    pixel ** p ;
    int i ;
    animated_gif * image ;

    /* Open the GIF image (read mode) */
    g = DGifOpenFileName( filename, &error ) ;
    if ( g == NULL ) 
    {
        fprintf( stderr, "Error DGifOpenFileName %s\n", filename ) ;
        return NULL ;
    }

    /* Read the GIF image */
    error = DGifSlurp( g ) ;
    if ( error != GIF_OK ) {
        fprintf( stderr, 
                "Error DGifSlurp: %d <%s>\n", error, GifErrorString(g->Error) ) ;
        return NULL ;
    }

    /* Grab the number of images and the size of each image */
    n_images = g->ImageCount ;

    width = (int *)malloc( n_images * sizeof( int ) ) ;
    if ( width == NULL ) {
        fprintf( stderr, "Unable to allocate width of size %d\n",
                n_images ) ;
        return 0 ;
    }

    height = (int *)malloc( n_images * sizeof( int ) ) ;
    if ( height == NULL ) {
        fprintf( stderr, "Unable to allocate height of size %d\n",
                n_images ) ;
        return 0 ;
    }

    /* Fill the width and height */
    for ( i = 0 ; i < n_images ; i++ ) {
        width[i] = g->SavedImages[i].ImageDesc.Width ;
        height[i] = g->SavedImages[i].ImageDesc.Height ;

#if SOBELF_DEBUG
        printf( "Image %d: l:%d t:%d w:%d h:%d interlace:%d localCM:%p\n",
                i, 
                g->SavedImages[i].ImageDesc.Left,
                g->SavedImages[i].ImageDesc.Top,
                g->SavedImages[i].ImageDesc.Width,
                g->SavedImages[i].ImageDesc.Height,
                g->SavedImages[i].ImageDesc.Interlace,
                g->SavedImages[i].ImageDesc.ColorMap
                ) ;
#endif
    }


    /* Get the global colormap */
    colmap = g->SColorMap ;
    if ( colmap == NULL ) {
        fprintf( stderr, "Error global colormap is NULL\n" ) ;
        return NULL ;
    }

#if SOBELF_DEBUG
    printf( "Global CM: count:%d bpp:%d sort:%d\n",
            g->SColorMap->ColorCount,
            g->SColorMap->BitsPerPixel,
            g->SColorMap->SortFlag
            ) ;
#endif

    /* Allocate the array of pixels to be returned */
    p = (pixel **)malloc( n_images * sizeof( pixel * ) ) ;
    if ( p == NULL ) {
        fprintf( stderr, "Unable to allocate array of %d images\n",
                n_images ) ;
        return NULL ;
    }

    for ( i = 0 ; i < n_images ; i++ ) {
        p[i] = (pixel *)malloc( width[i] * height[i] * sizeof( pixel ) ) ;
        if ( p[i] == NULL ) {
        fprintf( stderr, "Unable to allocate %d-th array of %d pixels\n", i, width[i] * height[i] ) ;
        return NULL ;
        }
    }
    
    /* Fill pixels */

    /* For each image */
    for ( i = 0 ; i < n_images ; i++ ) {
        int j ;

        /* Get the local colormap if needed */
        if ( g->SavedImages[i].ImageDesc.ColorMap ) {

            /* TODO No support for local color map */
            fprintf( stderr, "Error: application does not support local colormap\n" ) ;
            return NULL ;

            colmap = g->SavedImages[i].ImageDesc.ColorMap ;
        }

        /* Traverse the image and fill pixels */
        for ( j = 0 ; j < width[i] * height[i] ; j++ ) {
            int c ;

            c = g->SavedImages[i].RasterBits[j] ;

            p[i][j].r = colmap->Colors[c].Red ;
            p[i][j].g = colmap->Colors[c].Green ;
            p[i][j].b = colmap->Colors[c].Blue ;
        }
    }

    /* Allocate image info */
    image = (animated_gif *)malloc( sizeof(animated_gif) ) ;
    if ( image == NULL ) 
    {
        fprintf( stderr, "Unable to allocate memory for animated_gif\n" ) ;
        return NULL ;
    }

    /* Fill image fields */
    image->n_images = n_images ;
    image->width = width ;
    image->height = height ;
    image->p = p ;
    image->g = g ;

#if SOBELF_DEBUG
    printf( "-> GIF w/ %d image(s) with first image of size %d x %d\n",
            image->n_images, image->width[0], image->height[0] ) ;
#endif

    return image ;
}

int output_modified_read_gif( char * filename, GifFileType * g ) {
    GifFileType * g2 ;
    int error2 ;

#if SOBELF_DEBUG
    printf( "Starting output to file %s\n", filename ) ;
#endif

    g2 = EGifOpenFileName( filename, false, &error2 ) ;
    if ( g2 == NULL )
    {
        fprintf( stderr, "Error EGifOpenFileName %s\n",
                filename ) ;
        return 0 ;
    }

    g2->SWidth = g->SWidth ;
    g2->SHeight = g->SHeight ;
    g2->SColorResolution = g->SColorResolution ;
    g2->SBackGroundColor = g->SBackGroundColor ;
    g2->AspectByte = g->AspectByte ;
    g2->SColorMap = g->SColorMap ;
    g2->ImageCount = g->ImageCount ;
    g2->SavedImages = g->SavedImages ;
    g2->ExtensionBlockCount = g->ExtensionBlockCount ;
    g2->ExtensionBlocks = g->ExtensionBlocks ;

    error2 = EGifSpew( g2 ) ;
    if ( error2 != GIF_OK ) 
    {
        fprintf( stderr, "Error after writing g2: %d <%s>\n", 
                error2, GifErrorString(g2->Error) ) ;
        return 0 ;
    }

    return 1 ;
}
int store_pixels( char * filename, animated_gif * image ) {
    int n_colors = 0 ;
    pixel ** p ;
    int i, j, k ;
    GifColorType * colormap ;

    /* Initialize the new set of colors */
    colormap = (GifColorType *)malloc( 256 * sizeof( GifColorType ) ) ;
    if ( colormap == NULL ) 
    {
        fprintf( stderr,
                "Unable to allocate 256 colors\n" ) ;
        return 0 ;
    }

    /* Everything is white by default */
    for ( i = 0 ; i < 256 ; i++ ) 
    {
        colormap[i].Red = 255 ;
        colormap[i].Green = 255 ;
        colormap[i].Blue = 255 ;
    }

    /* Change the background color and store it */
    int moy ;
    moy = (
            image->g->SColorMap->Colors[ image->g->SBackGroundColor ].Red
            +
            image->g->SColorMap->Colors[ image->g->SBackGroundColor ].Green
            +
            image->g->SColorMap->Colors[ image->g->SBackGroundColor ].Blue
            )/3 ;
    if ( moy < 0 ) moy = 0 ;
    if ( moy > 255 ) moy = 255 ;

#if SOBELF_DEBUG
    printf( "[DEBUG] Background color (%d,%d,%d) -> (%d,%d,%d)\n",
            image->g->SColorMap->Colors[ image->g->SBackGroundColor ].Red,
            image->g->SColorMap->Colors[ image->g->SBackGroundColor ].Green,
            image->g->SColorMap->Colors[ image->g->SBackGroundColor ].Blue,
            moy, moy, moy ) ;
#endif

    colormap[0].Red = moy ;
    colormap[0].Green = moy ;
    colormap[0].Blue = moy ;

    image->g->SBackGroundColor = 0 ;

    n_colors++ ;

    /* Process extension blocks in main structure */
    for ( j = 0 ; j < image->g->ExtensionBlockCount ; j++ )
    {
        int f ;

        f = image->g->ExtensionBlocks[j].Function ;
        if ( f == GRAPHICS_EXT_FUNC_CODE )
        {
            int tr_color = image->g->ExtensionBlocks[j].Bytes[3] ;

            if ( tr_color >= 0 &&
                    tr_color < 255 )
            {

                int found = -1 ;

                moy = 
                    (
                     image->g->SColorMap->Colors[ tr_color ].Red
                     +
                     image->g->SColorMap->Colors[ tr_color ].Green
                     +
                     image->g->SColorMap->Colors[ tr_color ].Blue
                    ) / 3 ;
                if ( moy < 0 ) moy = 0 ;
                if ( moy > 255 ) moy = 255 ;

#if SOBELF_DEBUG
                printf( "[DEBUG] Transparency color image %d (%d,%d,%d) -> (%d,%d,%d)\n",
                        i,
                        image->g->SColorMap->Colors[ tr_color ].Red,
                        image->g->SColorMap->Colors[ tr_color ].Green,
                        image->g->SColorMap->Colors[ tr_color ].Blue,
                        moy, moy, moy ) ;
#endif

                for ( k = 0 ; k < n_colors ; k++ )
                {
                    if ( 
                            moy == colormap[k].Red
                            &&
                            moy == colormap[k].Green
                            &&
                            moy == colormap[k].Blue
                       )
                    {
                        found = k ;
                    }
                }
                if ( found == -1  ) 
                {
                    if ( n_colors >= 256 ) 
                    {
                        fprintf( stderr, 
                                "Error: Found too many colors inside the image\n"
                               ) ;
                        return 0 ;
                    }

#if SOBELF_DEBUG
                    printf( "[DEBUG]\tNew color %d\n",
                            n_colors ) ;
#endif

                    colormap[n_colors].Red = moy ;
                    colormap[n_colors].Green = moy ;
                    colormap[n_colors].Blue = moy ;


                    image->g->ExtensionBlocks[j].Bytes[3] = n_colors ;

                    n_colors++ ;
                } else
                {
#if SOBELF_DEBUG
                    printf( "[DEBUG]\tFound existing color %d\n",
                            found ) ;
#endif
                    image->g->ExtensionBlocks[j].Bytes[3] = found ;
                }
            }
        }
    }

    for ( i = 0 ; i < image->n_images ; i++ )
    {
        for ( j = 0 ; j < image->g->SavedImages[i].ExtensionBlockCount ; j++ )
        {
            int f ;

            f = image->g->SavedImages[i].ExtensionBlocks[j].Function ;
            if ( f == GRAPHICS_EXT_FUNC_CODE )
            {
                int tr_color = image->g->SavedImages[i].ExtensionBlocks[j].Bytes[3] ;

                if ( tr_color >= 0 &&
                        tr_color < 255 )
                {

                    int found = -1 ;

                    moy = 
                        (
                         image->g->SColorMap->Colors[ tr_color ].Red
                         +
                         image->g->SColorMap->Colors[ tr_color ].Green
                         +
                         image->g->SColorMap->Colors[ tr_color ].Blue
                        ) / 3 ;
                    if ( moy < 0 ) moy = 0 ;
                    if ( moy > 255 ) moy = 255 ;

#if SOBELF_DEBUG
                    printf( "[DEBUG] Transparency color image %d (%d,%d,%d) -> (%d,%d,%d)\n",
                            i,
                            image->g->SColorMap->Colors[ tr_color ].Red,
                            image->g->SColorMap->Colors[ tr_color ].Green,
                            image->g->SColorMap->Colors[ tr_color ].Blue,
                            moy, moy, moy ) ;
#endif

                    for ( k = 0 ; k < n_colors ; k++ )
                    {
                        if ( 
                                moy == colormap[k].Red
                                &&
                                moy == colormap[k].Green
                                &&
                                moy == colormap[k].Blue
                           )
                        {
                            found = k ;
                        }
                    }
                    if ( found == -1  ) 
                    {
                        if ( n_colors >= 256 ) 
                        {
                            fprintf( stderr, 
                                    "Error: Found too many colors inside the image\n"
                                   ) ;
                            return 0 ;
                        }

#if SOBELF_DEBUG
                        printf( "[DEBUG]\tNew color %d\n",
                                n_colors ) ;
#endif

                        colormap[n_colors].Red = moy ;
                        colormap[n_colors].Green = moy ;
                        colormap[n_colors].Blue = moy ;


                        image->g->SavedImages[i].ExtensionBlocks[j].Bytes[3] = n_colors ;

                        n_colors++ ;
                    } else
                    {
#if SOBELF_DEBUG
                        printf( "[DEBUG]\tFound existing color %d\n",
                                found ) ;
#endif
                        image->g->SavedImages[i].ExtensionBlocks[j].Bytes[3] = found ;
                    }
                }
            }
        }
    }

#if SOBELF_DEBUG
    printf( "[DEBUG] Number of colors after background and transparency: %d\n",
            n_colors ) ;
#endif

    p = image->p ;

    /* Find the number of colors inside the image */
    for ( i = 0 ; i < image->n_images ; i++ )
    {

#if SOBELF_DEBUG
        printf( "OUTPUT: Processing image %d (total of %d images) -> %d x %d\n",
                i, image->n_images, image->width[i], image->height[i] ) ;
#endif

        for ( j = 0 ; j < image->width[i] * image->height[i] ; j++ ) 
        {
            int found = 0 ;
            for ( k = 0 ; k < n_colors ; k++ )
            {
                if ( p[i][j].r == colormap[k].Red &&
                        p[i][j].g == colormap[k].Green &&
                        p[i][j].b == colormap[k].Blue )
                {
                    found = 1 ;
                }
            }

            if ( found == 0 ) 
            {
                if ( n_colors >= 256 ) 
                {
                    fprintf( stderr, 
                            "Error: Found too many colors inside the image\n"
                           ) ;
                    return 0 ;
                }

#if SOBELF_DEBUG
                printf( "[DEBUG] Found new %d color (%d,%d,%d)\n",
                        n_colors, p[i][j].r, p[i][j].g, p[i][j].b ) ;
#endif

                colormap[n_colors].Red = p[i][j].r ;
                colormap[n_colors].Green = p[i][j].g ;
                colormap[n_colors].Blue = p[i][j].b ;
                n_colors++ ;
            }
        }
    }

#if SOBELF_DEBUG
    printf( "OUTPUT: found %d color(s)\n", n_colors ) ;
#endif


    /* Round up to a power of 2 */
    if ( n_colors != (1 << GifBitSize(n_colors) ) )
    {
        n_colors = (1 << GifBitSize(n_colors) ) ;
    }

#if SOBELF_DEBUG
    printf( "OUTPUT: Rounding up to %d color(s)\n", n_colors ) ;
#endif

    /* Change the color map inside the animated gif */
    ColorMapObject * cmo ;

    cmo = GifMakeMapObject( n_colors, colormap ) ;
    if ( cmo == NULL )
    {
        fprintf( stderr, "Error while creating a ColorMapObject w/ %d color(s)\n",
                n_colors ) ;
        return 0 ;
    }

    image->g->SColorMap = cmo ;

    /* Update the raster bits according to color map */
    for ( i = 0 ; i < image->n_images ; i++ )
    {
        for ( j = 0 ; j < image->width[i] * image->height[i] ; j++ ) 
        {
            int found_index = -1 ;
            for ( k = 0 ; k < n_colors ; k++ ) 
            {
                if ( p[i][j].r == image->g->SColorMap->Colors[k].Red &&
                        p[i][j].g == image->g->SColorMap->Colors[k].Green &&
                        p[i][j].b == image->g->SColorMap->Colors[k].Blue )
                {
                    found_index = k ;
                }
            }

            if ( found_index == -1 ) 
            {
                fprintf( stderr,
                        "Error: Unable to find a pixel in the color map\n" ) ;
                return 0 ;
            }

            image->g->SavedImages[i].RasterBits[j] = found_index ;
        }
    }


    /* Write the final image */
    if ( !output_modified_read_gif( filename, image->g ) ) { return 0 ; }

    return 1 ;
}
void apply_gray_filter( animated_gif * image ) {
    int i, j ;
    pixel ** p ;

    p = image->p ;

    for ( i = 0 ; i < image->n_images ; i++ )
    {
        for ( j = 0 ; j < image->width[i] * image->height[i] ; j++ )
        {
            int moy ;

            // moy = p[i][j].r/4 + ( p[i][j].g * 3/4 ) ;
            moy = (p[i][j].r + p[i][j].g + p[i][j].b)/3 ;
            if ( moy < 0 ) moy = 0 ;
            if ( moy > 255 ) moy = 255 ;

            p[i][j].r = moy ;
            p[i][j].g = moy ;
            p[i][j].b = moy ;
        }
    }
}
void apply_gray_line( animated_gif * image ) {
    int i, j, k ;
    pixel ** p ;

    p = image->p ;

    for ( i = 0 ; i < image->n_images ; i++ )
    {
        for ( j = 0 ; j < 10 ; j++ )
        {
            for ( k = image->width[i]/2 ; k < image->width[i] ; k++ )
            {
            p[i][CONV(j,k,image->width[i])].r = 0 ;
            p[i][CONV(j,k,image->width[i])].g = 0 ;
            p[i][CONV(j,k,image->width[i])].b = 0 ;
            }
        }
    }
}
void apply_blur_filter( animated_gif * image, int size, int threshold ) {
    int i, j, k ;
    int width, height ;
    int end = 0 ;
    int n_iter = 0 ;
    pixel ** p ;
	pixel * s_p;
    pixel * newp ;
    /* Get the pixels of all images */
    p = image->p ;

    /* Process all images */
    for ( i = 0 ; i < image->n_images ; i++ ) {
        n_iter = 0 ;
        width = image->width[i];
        height = image->height[i];

        /* Allocate array of new pixels */
        newp = (pixel *)malloc(width * height * sizeof( pixel ) ) ;

        /* Perform at least one blur iteration */
        do {
            end = 1 ;
            n_iter++ ;
			s_p = p[i];
            /* Apply blur on top part of image (10%) */
			apply_blur_top(height, width, size, s_p, newp);

            /* Copy the middle part of the image */
            for(j=height/10-size; j<height*0.9+size; j++) {
                for(k=size; k<width-size; k++) {
                    newp[CONV(j,k,width)].r = p[i][CONV(j,k,width)].r ; 
                    newp[CONV(j,k,width)].g = p[i][CONV(j,k,width)].g ; 
                    newp[CONV(j,k,width)].b = p[i][CONV(j,k,width)].b ; 
                }
            }

            /* Apply blur on the bottom part of the image (10%) */
            for(j=height*0.9+size; j<height-size; j++) {
                for(k=size; k<width-size; k++) {
                    int stencil_j, stencil_k ;
                    int t_r = 0 ;
                    int t_g = 0 ;
                    int t_b = 0 ;

                    for ( stencil_j = -size ; stencil_j <= size ; stencil_j++ ) {
                        for ( stencil_k = -size ; stencil_k <= size ; stencil_k++ ) {
                            t_r += p[i][CONV(j+stencil_j,k+stencil_k,width)].r ;
                            t_g += p[i][CONV(j+stencil_j,k+stencil_k,width)].g ;
                            t_b += p[i][CONV(j+stencil_j,k+stencil_k,width)].b ;
                        }
                    }
                    newp[CONV(j,k,width)].r = t_r / ( (2*size+1)*(2*size+1) ) ;
                    newp[CONV(j,k,width)].g = t_g / ( (2*size+1)*(2*size+1) ) ;
                    newp[CONV(j,k,width)].b = t_b / ( (2*size+1)*(2*size+1) ) ;
                }
            }

            for(j = size; j < height - size; j++) {
                for(k = size; k < width - size; k++) {
                    float diff_r ;
                    float diff_g ;
                    float diff_b ;

                    diff_r = (newp[CONV(j  ,k  ,width)].r - p[i][CONV(j  ,k  ,width)].r) ;
                    diff_g = (newp[CONV(j  ,k  ,width)].g - p[i][CONV(j  ,k  ,width)].g) ;
                    diff_b = (newp[CONV(j  ,k  ,width)].b - p[i][CONV(j  ,k  ,width)].b) ;

                    if ( diff_r > threshold || -diff_r > threshold || diff_g > threshold || -diff_g > threshold || diff_b > threshold || -diff_b > threshold) {
                        end = 0 ;
                    }

                    p[i][CONV(j  ,k  ,width)].r = newp[CONV(j  ,k  ,width)].r ;
                    p[i][CONV(j  ,k  ,width)].g = newp[CONV(j  ,k  ,width)].g ;
                    p[i][CONV(j  ,k  ,width)].b = newp[CONV(j  ,k  ,width)].b ;
                }
            }
        } while ( threshold > 0 && !end ) ;
        // printf( "Nb iter for image %d\n", n_iter ) ;
        free (newp) ;
    }

}
void apply_sobel_filter( animated_gif * image ) {
    int i, j, k ;
    int width, height ;

    pixel ** p ;

    p = image->p ;

    for ( i = 0 ; i < image->n_images ; i++ )
    {
        width = image->width[i] ;
        height = image->height[i] ;

        pixel * sobel ;

        sobel = (pixel *)malloc(width * height * sizeof( pixel ) ) ;

        for(j=1; j<height-1; j++)
        {
            for(k=1; k<width-1; k++)
            {
                int pixel_blue_no, pixel_blue_n, pixel_blue_ne;
                int pixel_blue_so, pixel_blue_s, pixel_blue_se;
                int pixel_blue_o , pixel_blue  , pixel_blue_e ;

                float deltaX_blue ;
                float deltaY_blue ;
                float val_blue;

                pixel_blue_no = p[i][CONV(j-1,k-1,width)].b ;
                pixel_blue_n  = p[i][CONV(j-1,k  ,width)].b ;
                pixel_blue_ne = p[i][CONV(j-1,k+1,width)].b ;
                pixel_blue_so = p[i][CONV(j+1,k-1,width)].b ;
                pixel_blue_s  = p[i][CONV(j+1,k  ,width)].b ;
                pixel_blue_se = p[i][CONV(j+1,k+1,width)].b ;
                pixel_blue_o  = p[i][CONV(j  ,k-1,width)].b ;
                pixel_blue    = p[i][CONV(j  ,k  ,width)].b ;
                pixel_blue_e  = p[i][CONV(j  ,k+1,width)].b ;

                deltaX_blue = -pixel_blue_no + pixel_blue_ne - 2*pixel_blue_o + 2*pixel_blue_e - pixel_blue_so + pixel_blue_se;             

                deltaY_blue = pixel_blue_se + 2*pixel_blue_s + pixel_blue_so - pixel_blue_ne - 2*pixel_blue_n - pixel_blue_no;

                val_blue = sqrt(deltaX_blue * deltaX_blue + deltaY_blue * deltaY_blue)/4;


                if ( val_blue > 50 ) 
                {
                    sobel[CONV(j  ,k  ,width)].r = 255 ;
                    sobel[CONV(j  ,k  ,width)].g = 255 ;
                    sobel[CONV(j  ,k  ,width)].b = 255 ;
                } else
                {
                    sobel[CONV(j  ,k  ,width)].r = 0 ;
                    sobel[CONV(j  ,k  ,width)].g = 0 ;
                    sobel[CONV(j  ,k  ,width)].b = 0 ;
                }
            }
        }

        for(j=1; j<height-1; j++)
        {
            for(k=1; k<width-1; k++)
            {
                p[i][CONV(j  ,k  ,width)].r = sobel[CONV(j  ,k  ,width)].r ;
                p[i][CONV(j  ,k  ,width)].g = sobel[CONV(j  ,k  ,width)].g ;
                p[i][CONV(j  ,k  ,width)].b = sobel[CONV(j  ,k  ,width)].b ;
            }
        }

        free (sobel) ;
    }

}
int main( int argc, char ** argv ) {
    char * input_filename ; 
    char * output_filename ;
    animated_gif * image ;
	#ifdef _WIN32
	LARGE_INTEGER frequency;        // ticks per second
	LARGE_INTEGER t1, t2;           // ticks
	#else
	struct timeval t1, t2;
	#endif

    double duration ;

    if ( argc < 3 ) {
        fprintf( stderr, "Usage: %s input.gif output.gif\n Only %d argument(s) were passed\n", argv[0], argc ) ;
		for (int i = 1; i < argc; i++) {
			fprintf(stderr, "Argument %d: %s\n", i,argv[i]);
		}
		return 1 ;
    }
        
    input_filename = argv[1] ;
    output_filename = argv[2] ;
		/************************
		*	IMPORT GIF IMAGE	*
		************************/
    /* IMPORT Timer start */
	#ifdef _WIN32
	// get ticks per second
	QueryPerformanceFrequency(&frequency);
	// start timer
	QueryPerformanceCounter(&t1);
	#else
	gettimeofday(&t1, NULL);
	#endif

    /* Load file and store the pixels in array */
    image = load_pixels( input_filename ) ;
    if ( image == NULL ) { return 1 ; }
    /* IMPORT Timer stop */
	#ifdef _WIN32
	QueryPerformanceFrequency(&frequency); 	// get ticks per second
	QueryPerformanceCounter(&t2); 	// start timer
	duration = (t2.QuadPart - t1.QuadPart) * 1000.0 / frequency.QuadPart; 	// compute and print the elapsed time in millisec
	#else
	gettimeofday(&t2, NULL);
	duration = (t2.tv_sec - t1.tv_sec) + ((t2.tv_usec - t1.tv_usec) / 1e6);
	#endif
    //printf( "GIF loaded from file %s with %d image(s) in %lf s\n", input_filename, image->n_images, duration );
	fprintf(stdout, "L %lf\n", duration);

		/************************
		*	APPLY GRAY FILTER	*
		************************/
    /* FILTER Timer start */
	#ifdef _WIN32
	QueryPerformanceFrequency(&frequency);	// get ticks per second
	QueryPerformanceCounter(&t1);			// start timer
	#else
	gettimeofday(&t1, NULL);
	#endif
    /* Convert the pixels into grayscale */
    apply_gray_filter( image ) ;
	/* FILTER Timer stop */
	#ifdef _WIN32
	// get ticks per second
	QueryPerformanceFrequency(&frequency);
	// start timer
	QueryPerformanceCounter(&t2);
	// compute and print the elapsed time in millisec
	duration = (t2.QuadPart - t1.QuadPart) * 1000.0 / frequency.QuadPart;
	#else
	gettimeofday(&t2, NULL);
	duration = (t2.tv_sec - t1.tv_sec) + ((t2.tv_usec - t1.tv_usec) / 1e6);
	#endif
	fprintf(stdout, "G %lf\n", duration);

		/************************
		*	APPLY BLUR FILTER	*
		************************/
	/* FILTER Timer start */
	#ifdef _WIN32
	QueryPerformanceFrequency(&frequency); 	// get ticks per second
	QueryPerformanceCounter(&t1); 	// start timer
	#else
	gettimeofday(&t1, NULL);
	#endif
    /* Apply blur filter with convergence value */
    apply_blur_filter( image, 5, 20 ) ;
	/* FILTER Timer stop */
	#ifdef _WIN32
	QueryPerformanceFrequency(&frequency); 	// get ticks per second
	QueryPerformanceCounter(&t2); 	// start timer
	duration = (t2.QuadPart - t1.QuadPart) * 1000.0 / frequency.QuadPart; 	// compute and print the elapsed time in millisec
	#else
	gettimeofday(&t2, NULL);
	duration = (t2.tv_sec - t1.tv_sec) + ((t2.tv_usec - t1.tv_usec) / 1e6);
	#endif
	fprintf(stdout, "B %lf\n", duration);

		/************************
		*	APPLY SOBEL FILTER	*
		************************/
	/* FILTER Timer start */
	#ifdef _WIN32
	QueryPerformanceFrequency(&frequency); 	// get ticks per second
	QueryPerformanceCounter(&t1); 	// start timer
	#else
	gettimeofday(&t1, NULL);
	#endif
    /* Apply sobel filter on pixels */
    apply_sobel_filter( image ) ;
    /* FILTER Timer stop */
	#ifdef _WIN32
	QueryPerformanceFrequency(&frequency); 	// get ticks per second
	QueryPerformanceCounter(&t2); 	// start timer
	duration = (t2.QuadPart - t1.QuadPart) * 1000.0 / frequency.QuadPart; 	// compute and print the elapsed time in millisec
	#else
	gettimeofday(&t2, NULL);
	duration = (t2.tv_sec - t1.tv_sec) + ((t2.tv_usec - t1.tv_usec) / 1e6);
	#endif
	fprintf(stdout, "S %lf\n", duration);
    //printf( "SOBEL done in %lf s\n", duration ) ;

		/************************
		*	EXPORT GIF IMAGE	*
		************************/
    /* EXPORT Timer start */
	#ifdef _WIN32
	QueryPerformanceFrequency(&frequency); 	// get ticks per second
	QueryPerformanceCounter(&t1); 	// start timer
	#else
	gettimeofday(&t1, NULL);
	#endif
    /* Store file from array of pixels to GIF file */
    if ( !store_pixels( output_filename, image ) ) { return 1 ; }
    /* EXPORT Timer stop */
	#ifdef _WIN32
	QueryPerformanceFrequency(&frequency); 	// get ticks per second
	QueryPerformanceCounter(&t2); 	// start timer
	duration = (t2.QuadPart - t1.QuadPart) * 1000.0 / frequency.QuadPart; 	// compute and print the elapsed time in millisec
	#else
	gettimeofday(&t2, NULL);
	duration = (t2.tv_sec - t1.tv_sec) + ((t2.tv_usec - t1.tv_usec) / 1e6);
	#endif
	fprintf(stdout, "E %lf\n", duration);
    //printf( "Export done in %lf s in file %s\n", duration, output_filename ) ;

    return 0 ;
}
