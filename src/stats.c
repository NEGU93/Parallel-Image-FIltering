#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
    int nbLines = 0;
    int nbInputs = 0;
    
    char* line = NULL;
    size_t size = 0;

    double loadTime = 0;
    double sobelTime = 0;
    double exportTime = 0;
    double grayTime = 0;
    double blurTime = 0;

    while(getline(&line, &size, stdin) != -1)
    {
	nbLines++;	

	switch(line[0])
	{
	case 'L': // load
	    loadTime += atof(line+2);
	    break;

	case 'S': // sobel filter
	    sobelTime += atof(line+2);
	    break;

	case 'E': // export
	    exportTime += atof(line + 2);
	    break;

	case 'G': // gray filter
	    grayTime += atof(line + 2);
	    break;

	case 'B': // blur filter
	    blurTime += atof(line + 2);
	    break;

	default:
		nbLines--;
	    break;
	}
    }

    nbInputs = nbLines / 5;

    printf("%d inputs\n", nbInputs);

    printf("Load time : %lf\n", loadTime);
    printf("Gray filter time : %lf\n", grayTime);
    printf("Blur filter time : %lf\n", blurTime);
    printf("Sobel filter time : %lf\n", sobelTime);
    printf("Export time : %lf\n", exportTime);

    return 0;
}
