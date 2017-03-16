#include <stdio.h>
#include <stdlib.h>

double getNextVal(FILE* f, char* inputName)
{
    double t;
    if(!fscanf(f, "%s", inputName) || ! fscanf(f, "%lf", &t))
    {
	fprintf(stderr, "Error in ref time file\n");
	exit(1);
    }
    //printf("DEBUG: %s and %lf\n", inputName, t);

    return t;
}

int main(int argc, char** argv)
{
    int verbose = 0;
    if(argc < 2)
    {
	fprintf(stderr, "Need a reference time file as argument\n");
	exit(1);
    }

    if(argc > 2)
    {
	verbose = 1;
    }

    // Ref time
    char const* const fileName = argv[1];
    char inputName[256];
    FILE* file = fopen(fileName, "r");

    int nbLines = 0;
    int nbInputs = 0;
    
    char* line = NULL;
    size_t size = 0;

    double timeFile = 0;
    double perfOne = 0;
    double perf = 0; // performance


    while(getline(&line, &size, stdin) != -1)
    {
	nbLines++;	

	switch(line[0])
	{
	case 'L': // load
	    nbInputs++;
	    timeFile = atof(line+2);
	    break;

	case 'S': // sobel filter
	    timeFile += atof(line+2);
	    break;

	case 'E': // export
	    timeFile += atof(line + 2);
	    break;

	case 'G': // gray filter
	    timeFile += atof(line + 2);
	    break;

	case 'B': // blur filter
	    timeFile += atof(line + 2);
	    double tRef = getNextVal(file,inputName);
	    perfOne = (timeFile / tRef);
	    if(verbose)
		printf("%s\n\t%lf / %lf -> %lf\n", inputName, timeFile, tRef, perfOne);
	    perf += perfOne;
	    break;

	default:
	    nbLines--;
	    break;
	}
    }

    fclose(file);

    printf("\n%d inputs\n", nbInputs);

    printf("Performance: %lf\n", perf / nbInputs);

    return 0;
}
