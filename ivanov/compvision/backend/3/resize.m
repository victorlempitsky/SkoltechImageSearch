% im = imresize(im, 1024.0/max(size(im,1),size(im,2)));
folder='C:\Documents\SkolTech\CV_Course\holidays\jpg2';

listing = dir(folder);

ImagesNum=size(listing);
ImagesNum=ImagesNum(1);

for i=(1:ImagesNum)
    tic
    imtool close all
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
        im = imresize(testImage, 1024.0/max(size(testImage,1),size(testImage,2)));
%         imshow(im);
%         imsave(im, itemName);
        imwrite(im, itemName, 'PNG');
    end
    searched=i/ImagesNum*100;
    display(searched);
    toc
end