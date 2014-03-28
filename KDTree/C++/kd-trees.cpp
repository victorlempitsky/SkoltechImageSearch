// kd-trees.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "time.h"
#include <cstdlib>

extern int nodes = 0;

typedef struct node_s node;
typedef struct queue_s queue;

struct node_s
{
        int dimNumber;
		double dimVal;
		struct node_s* left;
		struct node_s* right;
		int isLeaf; // 0 or 1
		int* leafVector;
		char* id;
};

struct queue_s
{
        node* nodeToCheck;
		double priorityVal;
		double* distanceVector;
};

int cmpfunc (const void * a, const void * b)
{
   return ( *(int*)a - *(int*)b );
}

int dCmpfunc(const void * a, const void * b)
{
   double r;
   double*  a_;
   double* b_;

   a_ = (double*) a;
   b_ = (double*) b;

   r = (*a_) - (*b_);

   if (r > 0.0)
   {
	   return 1;
   }
   else
   {
	   if (r == 0)
	   {
		   return 0;
	   }
	   else
	   {
		   return -1;
	   }
   }
}

void getMedian(double* median, int* values, int len) 
{
		int* tmpArray = (int*) malloc(len*sizeof(int));

		// copy source data to temp array
		tmpArray = (int*) memcpy(tmpArray, values, len*sizeof(int));
		qsort(tmpArray, len, sizeof(int), cmpfunc);

		if (len % 2 == 0) 
        {
            *median = ((double)tmpArray[(len / 2) - 1] + ((double)tmpArray[len / 2])) / 2.0;
        } 
        else 
        {
            *median = (double)tmpArray[len / 2];
        }

		free(tmpArray);
}

void traverseLeftTree(node root, int level)
{
	int i;
	printf("%f\n", root.dimVal);

	level = level + 1;

	if(!root.isLeaf)
	{
		for (i = 0; i < level; i++)
		{
			printf(" ");
		}
		
		traverseLeftTree(*root.left, level);
	}
}


void getMean(double* mean, int* values, int len)
{
	int b;
    double sum = 0.0;
	int i = 0;

    for(i = 0; i < len; i++)
	{
		sum += (double)*values;
		values++;
	}

    *mean  = sum/(double)len;
}


void getVariance(double* variance, int* values, int len)
{
    double* mean;
	double temp = 0;
	int i = 0;

	mean = (double*) malloc(sizeof(double));

	getMean(mean, values, len);

	for(i = 0; i < len; i++)
	{
		temp += (*mean-((double)*values))*(*mean-((double)*values));
		values++;
	}

    *variance = temp/(double)len;
	free(mean);
}


int* getDimensionVector(int numDim, int* set,  int rowsAmount, int colsAmount)
{
	int i;
	int* vector;
	vector = (int*) malloc(rowsAmount*sizeof(int));

	for (i = 0; i < rowsAmount; i++)
	{
		memcpy(&vector[i], &set[colsAmount*i+numDim], sizeof(int));
	}

	return vector;
}



void makeTree(node* root, int* aSet, int rows, int cols)
{
	int* vector = NULL;
	double* varianceVector;
	double* varianceVectorCpy;
	int* maxVarianceVector;
	double maxVariance;
	int maxVarianceIdx;
	double* median;
	int i;
	int leftSize = 0;
	int rightSize = 0;
	double vectorVal;
	int* leftSet;
	int* rightSet;
	node* leftNode;
	node* rightNode;
	int j = 0;
	int a = 0;

	leftNode = (node*) malloc(sizeof(node));
	leftNode->dimNumber = -1;
	leftNode->dimVal = -1;
	leftNode->left = NULL;
	leftNode->right = NULL;
	leftNode->isLeaf = 0;
	leftNode->leafVector = NULL;
	leftNode->id = NULL;

	rightNode = (node*) malloc(sizeof(node));
	rightNode->dimNumber = -1;
	rightNode->dimVal = -1;
	rightNode->left = NULL;
	rightNode->right = NULL;
	rightNode->isLeaf = 0;
	rightNode->leafVector = NULL;
	rightNode->id = NULL;

	//printf("nodes left: %d\n", nodes);
	//vector = getDimensionVector(1, aSet, rows, cols);

	varianceVector = (double*) malloc(cols * sizeof(double) );
	median = (double*) malloc(sizeof(double));

	if (median == NULL)
	{
		a = 1; 
	}

	for (i = 0; i < cols; i++)
	{
		vector = getDimensionVector(i, aSet, rows, cols);
		getVariance(&varianceVector[i], vector, rows);
		free(vector);
	}

	varianceVectorCpy = (double*) malloc(cols*sizeof(double));

	varianceVectorCpy = (double*) memcpy(varianceVectorCpy, varianceVector, cols*sizeof(double));

	qsort(varianceVectorCpy, cols, sizeof(double), dCmpfunc);

	//for (i = 0; i < cols; i++)
	//{
	//	printf("%f ", varianceVectorCpy[i]);
	//}

	for (i = 0; i < cols; i++)
	{
		maxVariance = varianceVectorCpy[cols-1-i];

		if (maxVariance != 0.0)
		{
			break;
		}
	}
	
	//if (maxVariance == 0.0)
	//{
	//	for (i = 0; i < cols; i++)
	//	{
	//		printf("%f ", varianceVectorCpy[i]);
	//	}

	//	printf("\n");
	//	printf("\n");
	//	printf("------------------------");



	//	for (i = 0; i < cols; i++)
	//	{
	//		printf("%f ", varianceVector[i]);
	//	}

	//	printf("\n");
	//	printf("\n");
	//	printf("\n");
	//	for (i =0; i < rows; i++)
	//	{
	//		for (j = 0; j < cols; j++)
	//		{
	//			printf("%d ", aSet[i+j]);
	//		}
	//		printf("\n");
	//	}
	//	a = 1;
	//}

	// find dimension number with max variance
	for (i = 0; i < cols; i++)
	{
		if (varianceVector[i] == maxVariance )
		{
			maxVarianceIdx = i;
		}
	}

	// get max variance axe
	maxVarianceVector = getDimensionVector(maxVarianceIdx, aSet, rows, cols);
	getMedian(median, maxVarianceVector, rows);

	
	// create two arrays
	// determine array sizes
	for (i = 0; i < rows; i++)
	{
		vectorVal = (double) maxVarianceVector[i];

		if (vectorVal <= *median)
		{ leftSize++; }
		else
		{ rightSize++; }
	}

	// set root values
	root->dimNumber = maxVarianceIdx;
	root->dimVal = *median;

	// get memory from branches
	leftSet = (int*) malloc(cols * leftSize * sizeof(int));
	rightSet = (int*) malloc(cols * rightSize * sizeof(int));

	// reset counters
	leftSize = 0;
	rightSize = 0;

	

	// split aSet into two parts according to median value 
	for (i = 0; i < rows; i++)
	{

		vectorVal = (double) maxVarianceVector[i];

		if (vectorVal <= *median)
		{ 
			memcpy(&leftSet[leftSize * cols], &aSet[i * cols], cols * sizeof(int)); 
			leftSize++;
		}
		else
		{ 
			memcpy(&rightSet[rightSize * cols], &aSet[i * cols], cols * sizeof(int));
			rightSize++; 
		}
	}

	//free(vector);
	free(varianceVector);
	free(varianceVectorCpy);
	free(maxVarianceVector);
	free(aSet); // delete input set (matrix) to store some memory. In futher calculation it is not used. Used only its split version
	free(median);
	
	// making a leaf or node for right and left root branches
	if (leftSize > 1)
	{
		root->left = leftNode;
		makeTree(leftNode, leftSet, leftSize, cols);
	}
	else
	{
		leftNode->isLeaf = 1;
		leftNode->leafVector = leftSet;
		root->left = leftNode;
		nodes--;
	}

	if (rightSize > 1)
	{
		root->right = rightNode;
		makeTree(rightNode, rightSet, rightSize, cols );
	}
	else
	{
		rightNode->isLeaf = 1;
		rightNode->leafVector = rightSet;
		root->right = rightNode;
		nodes--;
	}
}



void showTree(node* root, int level)
{
	int i = 0;

	if(!root->isLeaf)
	{
		for (i = 0; i < level; i++)
		{
			printf(" ");
		}
		
		level++;

		showTree(root->left, level);
		showTree(root->right, level);
	}
	else
	{
		printf("level: "); printf("%d", level);
		printf(" node:[ "); printf("%d ", root->leafVector[0]); printf(" %d]\n", root->leafVector[1]);

	}
}

double getDistance(int* vector1, int* vector2, int vectorLenght)
{
	double sum = 0.0;
	int i;
	
	for(i = 0; i < vectorLenght; i++)
	{
		sum += (((double)vector1[i])-((double)vector2[i])) * (((double)vector1[i])-((double)vector2[i]));
	}

	return sum;
}

double getVectorSum(double* vector, int len)
{
	double result = 0.0;
	int i = 0;

	for (i = 0; i < len; i++)
	{
		result += (double)vector[i];
	}

	return result;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int* search(int* point, node* tree, int maxLeafsVisited, int pointDimensons)
{
	int i;
	int theBestPriorityIndex;
	int* result;
	double bestDistance;
	double rightDistance;
	double leftDistance;
	double* leftDistanceVector = NULL;
	double* rightDistanceVector = NULL;
	queue** queueArr;
	int queueCounter = 0;
	int queueIndexer = 0;
	int leafsVisited = 0;
	queue* queueItem;
	node* nodeToCheck;
	int queueSize = maxLeafsVisited*maxLeafsVisited;
	double theBestPriorityVal = 0;
	int queueIdx;
	nodeToCheck = NULL;
	double* distanceVector = NULL;
	double* zeroDistanceVector;
	double newBestDistance;

	zeroDistanceVector = (double*) malloc(pointDimensons * sizeof(double));

	for (i = 0; i < pointDimensons; i++)
	{
		zeroDistanceVector[i] = 0.0;
	}

	queueArr = (queue**) malloc (sizeof(queue*) * queueSize);
	bestDistance = 1000000000000000000000000000.0;
	result = (int*) malloc(pointDimensons * sizeof(int));

	for (i = 0; i < queueSize; i++ )
	{
		queueArr[i] = NULL;
	}
	
	// make initial node for the queue
	queueItem = (queue*) malloc(sizeof(queue));
	queueItem->nodeToCheck = tree;
	queueItem->priorityVal = 0.0;
	queueItem->distanceVector = (double*) malloc(pointDimensons * sizeof(double));
	memcpy(queueItem->distanceVector, zeroDistanceVector, pointDimensons * sizeof(double));

	queueArr[queueIndexer] = queueItem;
	queueIndexer++;
	queueCounter++;


	while( (queueCounter > 0) && (leafsVisited < maxLeafsVisited))
	{
		//take the node from the queue with the lowest priorityVal value
		theBestPriorityVal = bestDistance;
		theBestPriorityIndex = -1;
		// search for lowest value
		for (i = 0; i < queueIndexer; i++ )
		{
			if (queueArr[i] != NULL)
			{
				if (queueArr[i]->priorityVal <= theBestPriorityVal )
				{
					theBestPriorityVal = queueArr[i]->priorityVal;
					nodeToCheck = queueArr[i]->nodeToCheck;
					distanceVector = queueArr[i]->distanceVector;
					theBestPriorityIndex = i;
				}
			}
		}

		// all points with the possible smallest distances checked -> interrupt the loop 
		if (theBestPriorityIndex == -1)
		{
			break;
		}


		if (nodeToCheck->isLeaf)
		{
			// TO DO calculation of the best distance and winner leaf
			newBestDistance = getDistance(point, nodeToCheck->leafVector, pointDimensons);
			
			if (bestDistance > newBestDistance)
			{
				bestDistance = newBestDistance;
				memcpy(result, nodeToCheck->leafVector, pointDimensons * sizeof(int));

			}

			leafsVisited++;
		}
		else
		{
			// put the branches of the node into the queue

			leftDistanceVector = (double*) malloc(pointDimensons * sizeof(double));
			rightDistanceVector = (double*) malloc(pointDimensons * sizeof(double));
			
			// check the distance - decide where to go
			if(nodeToCheck->dimVal > ((double)point[nodeToCheck->dimNumber]))
			{
				// go left branch
				leftDistance = 0.0;
				memcpy(leftDistanceVector, distanceVector, pointDimensons * sizeof(double));

				//---------------
				memcpy(rightDistanceVector, distanceVector, pointDimensons * sizeof(double));
				
				if (nodeToCheck->right->isLeaf)
				{
					rightDistance = 0.0;
				}
				else
				{
					rightDistance = getVectorSum(rightDistanceVector, pointDimensons);
					rightDistanceVector[nodeToCheck->dimNumber] = (((double)point[nodeToCheck->dimNumber]) - nodeToCheck->dimVal) * (((double)point[nodeToCheck->dimNumber]) - nodeToCheck->dimVal);
				}
			}
			else
			{
				// go right branch
				memcpy(leftDistanceVector, distanceVector, pointDimensons * sizeof(double));
				
				if (nodeToCheck->left->isLeaf)
				{
					leftDistance = 0.0;
				}
				else
				{
					leftDistance = getVectorSum(leftDistanceVector, pointDimensons);
					leftDistanceVector[nodeToCheck->dimNumber] = (((double)point[nodeToCheck->dimNumber]) - nodeToCheck->dimVal) * (((double)point[nodeToCheck->dimNumber]) - nodeToCheck->dimVal);
				}

				//---------------
				rightDistance = 0.0;
				memcpy(rightDistanceVector, distanceVector, pointDimensons * sizeof(double));

			}
		
			// add two nodes to priority queue
			queue* leftNodeQueueItem = (queue*) malloc(sizeof(queue));
			queue* rightNodeQueueItem = (queue*) malloc(sizeof(queue));
			
			leftNodeQueueItem->nodeToCheck = nodeToCheck->left;
			leftNodeQueueItem->priorityVal = leftDistance;
			leftNodeQueueItem->distanceVector = leftDistanceVector;

			queueArr[queueIndexer] = leftNodeQueueItem;
			queueIndexer++;
			queueCounter++;

			rightNodeQueueItem->nodeToCheck = nodeToCheck->right;
			rightNodeQueueItem->priorityVal = rightDistance;
			rightNodeQueueItem->distanceVector = rightDistanceVector;

			queueArr[queueIndexer] = rightNodeQueueItem;
			queueIndexer++;
			queueCounter++;
		}

		queueItem = queueArr[theBestPriorityIndex];
		queueArr[theBestPriorityIndex] = NULL;
		free(queueItem);

		queueCounter--;
	}

	free(queueArr);
//	free(queueItem);
	return result;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int _tmain(int argc, _TCHAR* argv[])
{
	int i;
	node* root;
	int* aSet;
	int rows;
	int cols;
	double tmp;
	int* r;
	int* point;

	root = (node*) malloc(sizeof(node));
	root->dimNumber = -1;
	root->dimVal = -1;
	root->left = NULL;
	root->right = NULL;
	root->isLeaf = 0;
	root->leafVector = NULL;
	root->id = NULL;
	
	//rows - points (vectors)
	//rows = 6;

	////// cols - dimensions - SIFT size (dimensionality)
	//cols = 2;

	//aSet = (int*) malloc( rows * cols * sizeof(int) );

	// even index - X coordinate
	// odd  index - Y coordinate
	//aSet[0] = 1;
	//aSet[1] = 1;

	//aSet[2] = 3;
	//aSet[3] = 2;

	//aSet[4] = 5;
	//aSet[5] = 3;

	//aSet[6] = 2;
	//aSet[7] = 5;

	//aSet[8] = 4;
	//aSet[9] = 6;

	//aSet[10] = 7;
	//aSet[11] = 7;
	///////////////////////////////////
	//aSet[12] = 12;
	//aSet[13] = 12;

	//aSet[14] = 15;
	//aSet[15] = 15;

	//aSet[16] = 17;
	//aSet[17] = 17;

	//aSet[18] = 68;
	//aSet[19] = 90;

	//aSet[20] = 11;
	//aSet[21] = 78;

	//srand(time(NULL));

	rows = 150000;
	cols = 128;

	tmp = rows * cols * sizeof(int);
	printf("%f\n", ((double)tmp)/1024/1024);
	printf("%d\n", sizeof(node));
	printf("%d\n", sizeof(int));
	printf("%d\n", sizeof(short));

	aSet = (int*) malloc( rows * cols * sizeof(int) );

	for (i = 0; i < rows * cols; i++ )
	{
		aSet[i] = i;
	}

	point = (int*) malloc(cols*sizeof(int));

	for (i = 0; i < cols; i++ )
	{
		point[i] = 120;
	}


	//memcpy(point, aSet, cols * sizeof(int));


	
	clock_t start = clock();

	makeTree(root, aSet, rows, cols); // <-- aSet is cleared inside this function
	//showTree(root, 0);
	
	clock_t end = clock();
	float seconds = (float)(end - start) / CLOCKS_PER_SEC;
	
	printf("construction time: %f\n", seconds);

	//------------------- search -------------------
 	start = clock();

	r = search(point, root, 50, cols);

	end = clock();
	seconds = (float)(end - start) / CLOCKS_PER_SEC;
	printf("search time: %f\n", seconds);
	int r_;
	int p_;
	// check the result

	for (i = 0; i < cols; i++)
	{
		r_ = r[i];
		p_ = point[i];

		if (r[i]== 0 && r[cols-1]== 127)
		{
			printf("Ok"); break;
		}
	}


	getchar();
	
	return 0;
}







