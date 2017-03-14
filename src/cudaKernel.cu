#include "cudaKernel.h"
#include <cuda_runtime.h>
#include <cuda.h>

__global__ void apply_blur_kernel(int height, int width, int size, pixel * p, pixel * newp, int threshold) {
	int j, k;
	int row = blockDim.x * blockIdx.x + threadIdx.x;
	int	col = blockDim.y * blockIdx.y + threadIdx.y;
	//cuPrintf("j = %d + %d < %d. j+= %d\n", row, size, height / 10 - size, blockDim.y );
	//cuPrintf("k = %d + %d < %d. k+= %d\n", col, size, width - size, blockDim.x);
	for (j = row + size; j < height - size; j += blockDim.x * gridDim.x ) {
		for (k = col + size; k < width - size; k += blockDim.y * gridDim.y ) {
			int stencil_j, stencil_k;
			int t = 0;

			for (stencil_j = -size; stencil_j <= size; stencil_j++) {
				for (stencil_k = -size; stencil_k <= size; stencil_k++) {
					switch(threadIdx.z) {
						case 0:
							t += p[CONV(j + stencil_j, k + stencil_k, width)].r;
							break;
						case 1:
							t += p[CONV(j + stencil_j, k + stencil_k, width)].g;
							break;
						case 2:
							t += p[CONV(j + stencil_j, k + stencil_k, width)].b;
							break;
					}
				}
			}

			switch(threadIdx.z) {
				case 0:
					newp[CONV(j, k, width)].r = t / ((2 * size + 1)*(2 * size + 1));
					break;
				case 1:
					newp[CONV(j, k, width)].g = t / ((2 * size + 1)*(2 * size + 1));
					break;
				case 2:
					newp[CONV(j, k, width)].b = t / ((2 * size + 1)*(2 * size + 1));
					break;
			}
		}
	}
}
__global__ void apply_kernel(int height, int width, int size, pixel * myImg, pixel * newp, int threshold, int *end) {
	int j, k;
	int row = blockDim.x * blockIdx.x + threadIdx.x;
	int	col = blockDim.y * blockIdx.y + threadIdx.y;	

	for (j = row + size; j < height - size; j += blockDim.x * gridDim.x ) {
		for (k = col + size; k < width - size; k += blockDim.y * gridDim.y ) {
		    float diff;

			switch(threadIdx.z) {
				case 0:
					diff = newp[CONV(j,k,width)].r - myImg[CONV(j,k,width)].r;
					break;
				case 1:
					diff = newp[CONV(j,k,width)].g - myImg[CONV(j,k,width)].g;
					break;
				case 2:
					diff = newp[CONV(j,k,width)].b - myImg[CONV(j,k,width)].b;
					break;
			}

		    if ( diff > threshold || -diff > threshold ) { * end = 0; }

			switch(threadIdx.z) {
				case 0:
					myImg[CONV(j,k,width)].r = newp[CONV(j,k,width)].r;
					break;
				case 1:
					myImg[CONV(j,k,width)].g = newp[CONV(j,k,width)].g;
					break;
				case 2:
					myImg[CONV(j,k,width)].b = newp[CONV(j,k,width)].b;
					break;
			}
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

int apply_blur_cuda(int height, int width, int size, pixel * p, int threshold) {
	pixel * d_p;
	pixel * d_new;
	int end = 1;
	int * d_end;
	dim3 gridDim(2, 2, 1);
	dim3 blockDim(8, 8, 3 /* Here it MUST be 3 */);
	/* Alloc everything in device */
	alloc_device_pixel_array(width, height, &d_p);
	alloc_device_pixel_array(width, height, &d_new);
	cudaMalloc((void**)&d_end, sizeof(int));
	//alloc_device_int(&end);
	/* Copy to memory */
	transfer_pixel_array_H2D(width*height, p, d_p);
	cudaMemcpy(d_end, &end, sizeof(int), cudaMemcpyHostToDevice);
	/* Call Kernel */
	//cudaPrintfInit();
	apply_blur_kernel<<<gridDim, blockDim>>>(height, width, size, d_p, d_new, threshold);
	apply_kernel<<<gridDim, blockDim>>>(height, width, size, d_p, d_new, threshold, d_end);
	//cudaPrintfDisplay(stdout, true);
    //cudaPrintfEnd();
	/* Copy the result */
	transfer_pixel_array_D2H(width*height, p, d_p);
	cudaMemcpy(&end, d_end, sizeof(int), cudaMemcpyDeviceToHost);
	/* Free everything in the device */
	cudaFree(d_p);
	cudaFree(d_new);	

	return end;
}


