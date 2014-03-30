%converting test image into bag-of-words representation
function Z_test = test_bag_of_words(kdtreeNS)
test_image_name = 'test.jpg';
test_imageData = imread(test_image_name);
test_I_gr = rgb2gray(test_imageData);
test_I =  im2single(test_I_gr);
[test_a, test_descr] = vl_sift(test_I);
test_size2 = size(test_descr, 2);
test_r1 = randint(200, 1, [1, test_size2]);
test_c = test_descr(: , test_r1);
z_i_ones = [];
for i=1:200
    ind = knnsearch(kdtreeNS, test_c(:, i)');
    z_i_ones = [z_i_ones ind];
end
Z_test = zeros(1, 11000, 'double');
for k=1:200
    tmp = z_i_ones(k);
    Z_test(tmp) = 1;
end
end