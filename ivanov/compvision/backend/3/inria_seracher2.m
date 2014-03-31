clear all;

%% Holidays SIFTs calculation 
folder='C:\Documents\SkolTech\CV_Course\holidays\resized_jpg2';

folder2save='C:\Documents\SkolTech\CV_Course\holidays\SIFTs_jpg2\';

listing = dir(folder);
ImagesNum=size(listing);
ImagesNum=ImagesNum(1);

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
        I=imread(itemPath);
        I = single(rgb2gray(I)) ;
        [f,d] = vl_sift(I) ;

        filename=strcat('data_',itemName(1:(end-4)));

        data.id=i;
        data.name=itemName;
        data.path=itemPath;
        data.SIFT=d;
        data.frame=f;

        path2save=strcat(folder2save,filename);

        save(path2save, 'data');
        
        clear I d f data
    end
    processed=i/ImagesNum*100;
    display(processed);
    toc
end