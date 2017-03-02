
// size of N tiles in h*w
void getTileSize(int h, int w, int N, int* size)
{
    int quotient = w / h;
    int nbX = (int)sqrt(N * quotient);
    int nbY = N / nbX;

    size[0] = h / nbX;
    size[1] = w / nbY;
}

int getPart(int height, int width, int size, int myRank, int nbTasks, int* output)
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

    if(myRank > groupSize) // on bottom ?
    {
        offsetX = height - size - stripeHeight;
        myRank -= groupSize;
    }

    int x = myRank / nbY;
    int y = myRank % nbY;
    if(x >= nbX)
    {
        return -1; // no work for this task
    }

    output[0] = offsetX + (x * tileSize[0]) + ((x < nbOverX) ? x : nbOverX);
    output[1] = offsetY + (y * tileSize[1]) + ((y < nbOverY) ? y : nbOverY);
    output[2] = output[0] + tileSize[0] + ((x < nbOverX) ? 1 : 0);
    output[3] = output[1] + tileSize[1] + ((y < nbOverY) ? 1 : 0);

    return 1;
}
