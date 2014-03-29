function [ relevant ] = FindRelevant( QitemName,listingId,QueryFolder,FolderIn )
% display(QitemName);
% display(listingId);
% display(FolderIn);

ifJpg=strfind(QitemName,'jpg');
QitemName=QitemName(1:(ifJpg-2));
% display(QitemName);
ifJpg=size(ifJpg);
ifJpg=ifJpg(1);

QitemName=str2double(QitemName);
queryImageH=QitemName-mod(QitemName,100);
QlistingIdH=listingId-mod(QitemName,100);
display(queryImageH);

FFolder=strcat(QueryFolder,num2str(FolderIn));
listing = dir(FFolder);
ImagesNum=size(listing,1);
% display(ImagesNum);
relevant=cell(0);

for i=(QlistingIdH:min((QlistingIdH+20),ImagesNum))
    item=listing(i);
    itemName=item.name;
    itemPath=strcat(FFolder,'\',itemName);
    ifJpg=strfind(itemName,'jpg');
    itemName=itemName(1:(ifJpg-2));
    itemName=str2double(itemName);
    itemNameH=itemName-mod(itemName,10);
    if (itemNameH==queryImageH)
        relevant{end+1}=[FolderIn, i];
    end
end

end

