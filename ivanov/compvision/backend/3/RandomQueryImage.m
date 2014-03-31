function [ I, itemPath, itemName, FolderIn, listingId ] = RandomQueryImage( QueryFolder, FoldersAmount )

a=randi(FoldersAmount);
FolderIn=a;
QueryFolder=strcat(QueryFolder,num2str(a));
listing = dir(QueryFolder);
ImagesNum=size(listing);
ImagesNum=ImagesNum(1);

a=randi(ImagesNum);
if (a<3)
    a=a+10;
end

listingId=a;

item=listing(a);
itemName=item.name;
itemPath=strcat(QueryFolder,'\',itemName);
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
end


end




