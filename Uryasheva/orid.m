A = imread('fragment1', 'jpg');
xSize = size(A, 1);
ySize = size(A, 2);
folderpath = '/Users/staicy/Downloads/oxbuild_images/';
listOfImg = dir(folderpath);
num = size(listOfImg, 1);
I = rgb2gray(A);
for i=1:num
    if ~listOfImg(i).isdir
        tmpName = listOfImg(i).name;
        if tmpName(1)~='.'
            fullName = strcat(folderpath, tmpName);
            B = imread(fullName, 'jpg');
            if size(B, 1)>=xSize && size(B, 2)>=ySize
                croppedB = B(1:xSize, 1:ySize, :);
                J = rgb2gray(croppedB);
                correl = corr2(I, J);
                if abs(correl - 1.0)<0.005
                    disp(tmpName);
                    image(B);
                    return;
                end
            end
        end
    end
end