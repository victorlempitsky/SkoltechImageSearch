function [C, codebook, names] = bag_of_words()
folderpath = 'jpg/';
images = dir(folderpath);
codebook = [];
names = {};
for i=1:size(images, 1)
    img_name = images(i).name;
    if ~images(i).isdir & ~(img_name(1)=='.')
        filename = strcat(folderpath, img_name);
        try
            imageData = imread(filename);
        catch exception
                [~, ~, extension] = fileparts(filename);
                switch extension
                    case '.jpg'
                        altFilename = strrep(filename, '.jpg', '.jpeg');
                    case '.jpeg'
                        altFilename = strrep(filename, '.jpeg', '.jpg');
                    case '.tif'
                        altFilename = strrep(filename, '.tif', '.tiff');
                    case '.tiff'
                        altFilename = strrep(filename, '.tiff', '.tif');
                    otherwise 
                        rethrow(exception);
                end
                try
                    imageData = imread(altFilename);
                catch exception2
                    % Rethrow original error.
                    rethrow(exception)
                end
        end

        I_gr = rgb2gray(imageData);
        I =  im2single(I_gr);
        [a, descr] = vl_sift(I);
        size2 = size(descr, 2);
        r1 = randint(200, 1, [1, size2]);
        c = descr(: , r1);
        codebook = [codebook c];
        names{end+1} = img_name;
    end
end

%Quantizing the descriptors to get visual words
[C, A] = vl_kmeans(single(codebook), 11000, 'verbose', 'distance', 'l1', 'algorithm', 'ANN');
end