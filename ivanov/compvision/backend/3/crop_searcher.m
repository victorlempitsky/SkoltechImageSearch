clear variables
clear, close all, imtool close all
crop='C:\Documents\SkolTech\CV_Course\crop1.jpg';
crop_same = imread(crop);
% crop='C:\Documents\SkolTech\CV_Course\crop2_gamma.jpg';
% crop_gamma = imread(crop);

folder='C:\Documents\SkolTech\CV_Course\oxbuild_images';
listing = dir(folder);

ImagesNum=size(listing);
ImagesNum=ImagesNum(1);

sizeCrop=size(crop_same);
found=0;
minDistance=inf;
for i=(1:ImagesNum)
    tic
    item=listing(i);
    itemName=item.name;
    itemPath=strcat(folder,'\',itemName);
    ifJpg=strfind(itemName,'jpg');
    ifJpg=size(ifJpg);
    ifJpg=ifJpg(1);
    if (ifJpg>0)
        ifJpg=1;
    end
    if (ifJpg==0)
        ifJpg=0;
    end  
    if (ifJpg==1)
        testImage=imread(itemPath);
        sizeImage=size(testImage);
        if ((sizeCrop(1)<=sizeImage(1)) && (sizeCrop(2)<=sizeImage(2)))
            queryCrop=testImage(1:sizeCrop(1),1:sizeCrop(2),:);
            distance=norm(double(queryCrop(:,:,1))-double(crop_same(:,:,1)),'fro');
            if (distance<minDistance)
                minDistance=distance;
                outputName=itemName;
                outputPath=itemPath;
            end 
        end
        imshow(queryCrop);
    end
    toc
    searched=i/ImagesNum*100;
    display(searched);
end

foundImage=imread(outputPath);
imshow(foundImage);


















