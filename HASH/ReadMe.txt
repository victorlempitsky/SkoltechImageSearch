----Code----

backeend/* - files that integrate module into Ivanov Sergey's website.
backend/backend2.m - Reworked template from Ivanonv Sergey to use min-hash algorithm.
backend/query1M.m - query the created database for duplicate images. Using URL of an image.

GetData.m - saves data for futher use. This data is used to create image database.
GetImages.m - get list of all images in SIFTs directory and save it.
Precision.m - calculate precision on Holidays database.
Prepare.m - combine all maps for images into one.
Vocabularies.m - create 30k and 100k vocabularies.
Vocabulary.m - create 30k and 100k vocabularies using SIFTS.
VocabularyRoot.m - create 30k and 100k vocabularies using RootSIFTS.
Vocabulary256.m - create two 255 words vocabularies.
foo.m - function to calculate map from the image.
foo2.m - functon to calculate min-hashes from the image.
query1M.m - query the created database for duplicate images. Using one image from 1M images that we have.
queryHolidays.m - query Holidays database.
sims.m - saves sketches maps for each image.
simsHolidays - create Holidays database.
simsMinHashes.m - saves min-hashes for all images.
test.m - file for various and random tests.

----Data----

Imgs.mat - list of sift files from SIFTs directory.
data.mat - get hash_funs, kd-trees, subs.
hm_500k.mat - map of sketches for 25k images from 1M.
hm_500k_30.mat - map of sketches for 300k images from 1M. (Cannot save map for more)
min_hashes_{i}.mat - min-hashes for i * 10000 images from 1M.
rootsifts.mat - 1M random root sifts from 1M images
sifts.mat - 1M random sifts from 1M images
sketches_100k_{i}.mat - maps of sketches from 1+(i-1)*10000 to i*10000 images
vocabulary_30k.mat - vocabulary for 30k words using 1M random sifts
vocabulary_30k_root.mat - vocabulary for 30k words using 1M random root sifts
vocabulary_100k.mat - vocabulary for 100k words using 1M random sifts
vocabulary_100k_root.mat - vocabulary for 100k words using 1M random root sifts
vocabulary_255.mat - two vocabularies for 255 words, using 1M random sifts, for incoding 1:64 sift dimensions and 65 to 128 dimensions separately.
vocabulary_256.mat - two vocabularies for 256 words, using 1M random sifts, for incoding 1:64 sift dimensions and 65 to 128 dimensions separately.
