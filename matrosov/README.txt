This subproject is about Large Scale image search using VLADs (Vector of Locally Aggregated Descriptors) on top of SIFTs. Most of the ideas are described in papers:
[1] "Three things everyone should know to improve object retrieval", Arandjelovic, Zisserman, 2012.
http://www.robots.ox.ac.uk/~vgg/publications/2012/Arandjelovic12/arandjelovic12.pdf
[2] "All about VLAD", Arandjelovic, Zisserman, 2013.
http://www.axes-project.eu/wp-content/uploads/2013/08/arandjelovic13.pdf

The query pipeline is the following:
	Image -> Root SIFTs -> VLAD -> PCA -> PQ

SIFT - Scale Invariant Feature Transformation
VLAD - Vector of Locally Aggregated Descriptors
PCA - Principal Component Analisys
PQ - Product Quantization
mAP - mean average precision
BoW - Bag-of-Words

I recommend you to start exploring this part of the project from LargeScale/backend.m or LargeScale/getPqPcaVladFromImg.m. If you have any questions, don't hesitate to ask me (mikhail dot matrosov at skolkovotech dot ru). Some research results can be seen in ./docs/CvSys_MikhailM.pdf

Dependencies:
	vl_feat (vlfeat.org) - Matlab CV library
	
Below is description of project's structure.

./LargeScale - devoted to search on 1M images datast, and measuring its performance.
	PqPcaVladData.m - class inherited from Matlab Handle, that allows you to pass it through reference and thus to save lots of memory.
	adaptVLADs.m - in [2] described, that you can improve accuracy by adjusting cluster centers for VLAD.
	backendNotParallel.m - Takes url or filename of an image as a query and returns ranks for each image from 1M. There is commented code inside it, so you can switch different modes of comparison - pq symmetric, pq assymetric and raw pca. For now implemented preliminary querying with symmetric pca, and then reranking with raw pca, that is the best tradeoff between accuracy and performance.
	getPqPcaVladFromImg.m - takes image and returns pq, pca, vlad and sift descriptors.
	pq.m - computes product quantization for an arbitrary ammount of encodings.
	pq_alldist.m - computes distance between pq encodings, simmetric. Similiar to vl_alldist2 or pdist.
	tcpserver.m - tcp server that enables matlab to be queried via local ports. Useful for coupling Matlab with python, java or whatever.
	VLAD2PCA.m - converts vlad to pca, using adapted centers for vlad.
	backend.m - parallel part of the search engine. Takes bunch of query urls and returns overall ranks.
	getVLADFromImg.m - takes image, returns its vlad descriptor.
	pq2pca.m - converts pq representation to pca (reverse operation is pq())
	waitFileServer.m - similiar to tcp server, except that it uses local temporary files to couple with other applications.

./LargeScale/eval: - evaluation and measuring performance of search on 1M + Holidays dataset under different conditions.
	evalPCA_baseline.m - computes mAP for raw pca
	evalPQPCA_Assymmetric.m - computes mAP for assymetric pq
	evalPQPCA_Symmetric.m - computes mAP  for symmetric pq
	showQueryResultsPCA.m - shows example of search result for raw pca
	showQueryResultsPQPCA.m - shows example of search result for pq
	showQueryResultsVLAD.m - show example of search result for raw vlads

./LargeScale/precompute: - calculate index for the dataset of 1M images
	composeFilenames.m - assemble filenames#.mat for # from 1 to 100
	computePCA4VLAD.m - computes pca coefficients
	computePQ4PCA.m - computes pq parameters
	computePQPCA_Holidays.m - computes pq representations for Holidays dataset
	precomputeEverything.m - meta script that describes the right sequence of computations
	computeMeans.m - calculates adapted centers, as described in [2], basically averaging all the vlads
	computePCARepresentations.m - computes pca representations based on vlad data
	computePQPCARepresentations.m - takes pca representations and saves pq representations
	computeVLADs.m - computes vlad representation for the whole dataset of 1M images
	prepareEvalPQPCA.m - merges 1M and Holidays, computes labels and etc

./binaryDescriptors: - there was an idea about binary descriptors
	bitcount.cpp - computes Hamming distance (bit-wise) for set of integers, matlab coupled
	bitcount.mexa64 - matlab compiled file
	bitcount_.cpp - not coupled with matlab
	compileBitcount.sh - compilation procedure for GNU/Linux

./clusterizing: - finding clusters, choosing best clusterization and so on.
	clusterCentersIDs.mat
	clusterizationsDist.m - computes distance between two clusterizations using some rule-of-thumb
	estimateMeanSumDist.m - estimates a base level of clusterization quality, so you can compare different approaches
	getDictionary.m - computes dictionary on 1M SIFTs using some different rule-of-thumb
	main.m - for a given set of clusterizations displays their pairwise distances
	selectClusterizations.m - selects a subset set of clusterizations for multivocVLAD
	sumDistances.m - returns subset of pairwise distances
	clusterizationDistances.mat - a symmetric matrix that contains pairwise distances between clusterizations
	computeMeans.m - computes dictionaries for VLAD, also stores found clusterizations as images with illustrating visual words
	generateSifts.m - calculates SIFTs for a set of images
	imgSet2imgGrid.m - takes 3D array and represents it as grid of images (2D array) so it can be seen as image
	resizeImgs.m - resizes down images for Holidays dataset
	showClusterizations.m - displays clusterizations

./common: - functions that are used from other subfolders and in some other subprojects.
	generateHolidaysLabels.m - Holidays image dataset is labeled and labels can be retrieved from images' filenames
	getBoW.m - computes Bag-of-Words representations
	getBoWFromImg.m - same but computes sifts by itself
	getMAP.m - computes mAP: takes encodings and labels and compare encoding to each other, retreiving mAP
	getVLAD.m - returns VLAD descriptor for a given set of SIFTs
	getVLADFromImg.m - same but also retrieves sifts from an image
	holidaysList.m - gets a list of filenames for Holidays dataset

./data: - contains interim data
	makeRootSifts.m - make root sifts from not root ones

./evalBoW: - evaluation for BoW approach
	computeEncodings.m - computes BoW encodings for Holidays
	main.m - evaluator
	query.m - makes a query
	tf_normalize.m - term-frequency normalization (search for tf-idf)

./evalColhist: - evaluation for Color Histograms approach
	colhist.m - returns color hisogram (3D array) of an image
	computeColhists.m - computes colhists for Holidays
	evalColhist.m - computes mAP for the approach
	holidaysList.m - list of filenames in Holidays
	imEqualizeHist.m - histogram equalization. works for color images, unlike Matlab's histeq()
	main.m - shows examples of query results
	query.m - makes a query and returns some results

./evalVlad: - evaluation of VLAD approach on Holidays
	computeEncodings.m - computes VLAD encodings for Holidays
	main.m - measures mAP
	query.m - makes a query and returns some results
	showQueryResults.m - shows examples of query results 

./results: - some visualisations of results
	byteho_roc.png - BoW
	colhist.png  - Color Histograms
	vlad_roc.png - VLAD

./taster1: - solution for Taster challenge 1
	answers.txt - computed answers
	compute_ap.cpp
	examples.m - stuff
	imEqualizeHist.m - histogram equalization. works for color images, unlike Matlab's histeq()
	imgdiff.m - euclidian difference between images
	imgsList.m - saves list of images
	main.m - solution's main file

./taster2: - solution for Taster challenge 2
	buildROC.m - builds precision vs recall plot
	computeEncodings.m - computes representations
	computeMeans.m - calculates dictionary
	getByteho.m - computes BoW encoding
	holidaysList.m - list of filenames in Holidays
	imgsList.m - saves list of images
	main.m - solution's main file
	query.m - returns result for a query

