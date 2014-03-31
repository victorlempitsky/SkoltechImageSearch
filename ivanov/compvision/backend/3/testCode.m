InriaPath='C:\Documents\SkolTech\CV_Course\holidays\from Inria\siftgeo';

listing = dir(InriaPath);
FilesNum=size(listing,1);
counter=0;
SubFolder=cell(0);
SIFTsArray=cell(0);
IdsArray=cell(0);
limit=0;
numSIFTs=cell(0);

for j=(1:FilesNum)
    itemSIFTs=listing(j);
    if (strcmp(itemSIFTs.name,'.')~=1) && (strcmp(itemSIFTs.name,'..')~=1)
        limit=limit+1;
        pathSIFTs=strcat(InriaPath,'\',itemSIFTs.name);
        [v, meta] = siftgeo_read (pathSIFTs);
        v=v';

        a=size(v,2);

        SIFTsArray{end+1}=v;

        processed=j/ImagesNum*100;
        display(processed);
    end   
end

SIFTsArray=cell2mat(SIFTsArray);















