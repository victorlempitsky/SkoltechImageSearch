Crop=[];
for i=(1:answ)
    c=output(i,1);
    folderPath=strcat(QueryFolder,num2str(c));
    listing = dir(folderPath);
    item=listing(output(i,2));
    itemName=item.name;
    itemPath=strcat(folderPath,'\',itemName);
    out=imread(itemPath);
    Crop=[Crop; out];
end

imshow(Crop);