A = imread('fragment1', 'jpg');
h = vision.GammaCorrector(2.0,'Correction','De-gamma');
Agamma = step(h, A);

xSize = size(Agamma, 1);
ySize = size(Agamma, 2);
folderpath = '/Users/staicy/Downloads/oxbuild_images/';
listOfImg = dir(folderpath);
num = size(listOfImg, 1);
I = rgb2gray(Agamma);

GreatestCorrel = 0.0;
GreatestName = '';

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
                if correl >= GreatestCorrel
                    GreatestCorrel = correl;
                    GreatestName = tmpName;
                end
            end
        end
    end
end

disp(GreatestName);