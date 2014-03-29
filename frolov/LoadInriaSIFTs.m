function [SIFTsArray,IdsArray,SubFolder,numSIFTs] = LoadInriaSIFTs( folder )

%% input example
% folder - folder with SIFT descriptors (may contain other folders)
% folder='C:\Documents\SkolTech\CV_Course\holidays\SIFTs';

% InriaPath='C:\Documents\SkolTech\CV_Course\holidays\Inria_SIFTs';
% folder=InriaPath;


listing = dir(folder);
SubfoldersNum=size(listing);
SubfoldersNum=SubfoldersNum(1);
counter=0;
SubFolder=cell(0);
SIFTsArray=cell(0);
IdsArray=cell(0);
limit=0;
numSIFTs=cell(0);
for i=(1:SubfoldersNum)
    item=listing(i);
    SubFolderName=item.name;
    if (strcmp(SubFolderName,'.')~=1) && (strcmp(SubFolderName,'..')~=1)
        counter=counter+1;
        listingSIFTs = dir(strcat(folder,'\',SubFolderName));
        SubFolder{counter}=strcat(folder,'\',SubFolderName);
        ImagesNum=size(listingSIFTs);
        ImagesNum=ImagesNum(1);
%         if (counter==1)
%             SIFTs=[];
%             Ids=[];
%         end
%         if (counter>1)
%             SIFTsArray{end+1}=SIFTs;
%             IdsArray{end+1}=Ids;
%             SIFTs=[];
%             Ids=[];
%             limit=0;
%         end
        for j=(1:ImagesNum)
            itemSIFTs=listingSIFTs(j);
            if (strcmp(itemSIFTs.name,'.')~=1) && (strcmp(itemSIFTs.name,'..')~=1)
                limit=limit+1;
                pathSIFTs=strcat(folder,'\',SubFolderName,'\',itemSIFTs.name);
                [v, meta] = siftgeo_read (pathSIFTs);
                v=v';
                
                imageSIFTs=v;
                a=size(imageSIFTs);
                imageIds=zeros(2,a(2));
                imageIds(1,:)=j;
                imageIds(2,:)=counter;
                numSIFTs{end+1}=[counter; j; a(2)];
%                 imageFrames=data.frame;
                
%                 imageSIFTs=uint16(imageSIFTs);
%                 
%                 imageSIFTs(end+1,:)=0;
%                 imageSIFTs(end+1,:)=id;
%                 imageSIFTs(end+1,:)=counter;
%                 SIFTs=[SIFTs, imageSIFTs];

                SIFTsArray{end+1}=imageSIFTs;
                IdsArray{end+1}=imageIds;
%                 if (limit==50)
%                     SIFTsArray{end+1}=SIFTs;
%                     SIFTs=[];
%                     limit=0;
%                 end
                
                processed=j/ImagesNum*100;
                display(counter);
                display(processed);
            end   
        end
    end
end

SIFTsArray=cell2mat(SIFTsArray);
IdsArray=cell2mat(IdsArray);
numSIFTs=cell2mat(numSIFTs);
end









































































