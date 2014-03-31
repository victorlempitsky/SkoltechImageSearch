clear variables
clear, close all, imtool close all
crop='C:\Documents\SkolTech\CV_Course\crop1.jpg';
crop_same = imread(crop);
crop='C:\Documents\SkolTech\CV_Course\crop2_gamma.png';
crop_gamma = imread(crop);
answer='C:\Documents\SkolTech\CV_Course\oxbuild_images\all_souls_000013.jpg';
answer=imread(answer);

folder='C:\Documents\SkolTech\CV_Course\oxbuild_images';
listing = dir(folder);

ImagesNum=size(listing);
ImagesNum=ImagesNum(1);

sizeCrop=size(crop_gamma);
found=0;
Npixels=555;
output=cell(0);

pixel1=zeros(Npixels,5);

for i=(1:Npixels)
    a=randi(sizeCrop(1));
    b=randi(sizeCrop(2));
    pixel1(i,1)=a;
    pixel1(i,2)=b;
end

averQueryCrop1=0;
averCropGamma1=0;

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
            imshow(queryCrop);
            for j=(1:Npixels)
                a=pixel1(j,1);
                b=pixel1(j,2);
                pixel1(j,3)=queryCrop(a,b,1);
                pixel1(j,4)=crop_gamma(a,b,1);
            end
            
%             averQueryCrop1=median(median(queryCrop(:,:,3)));
%             averCropGamma1=median(median(crop_gamma(:,:,3)));
%             averQueryCrop1=mean(mean(queryCrop(:,:,1)));
%             averCropGamma1=mean(mean(crop_gamma(:,:,1)));
            averQueryCrop1=median(median(queryCrop(:,:,1)));
            averCropGamma1=median(median(crop_gamma(:,:,1)));
            
            for j=(1:Npixels)
                if ((pixel1(j,3)>=averQueryCrop1) && (pixel1(j,4)>=averCropGamma1))
                    pixel1(j,5)=1;
                end
                if ((pixel1(j,3)<=averQueryCrop1) && (pixel1(j,4)<=averCropGamma1))
                    pixel1(j,5)=1;
                end
            end
            
            if ((all(pixel1(:,5)==1)))
                outputName=itemName;
                outputPath=itemPath;
                output{end+1}=itemPath;
            end 
            pixel1(:,5)=0;
        end
%         imshow(queryCrop);
    end
    searched=i/ImagesNum*100;
    display(searched);
    toc
end

foundImage=imread(outputPath);
imshow(foundImage);


















