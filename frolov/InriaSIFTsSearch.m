% SIFTsFolder='C:\Documents\SkolTech\CV_Course\holidays\SIFTs';
QueryFolder='C:\Documents\SkolTech\CV_Course\holidays\resized_jpg';
SIFTsFolder='C:\Documents\SkolTech\CV_Course\holidays\SIFTs_TH5';
InriaPath='C:\Documents\SkolTech\CV_Course\holidays\Inria_SIFTs';

ImPath='C:\Documents\SkolTech\CV_Course\input.jpg';

%% Load SIFTs dataset
tic
% [SIFTsArray,IdsArray,SubFolder,numSIFTs]=LoadSIFTs(SIFTsFolder);
% [SIFTsArray,IdsArray,SubFolder,numSIFTs] = LoadInriaSIFTs( InriaPath );
% numSIFTs=numSIFTs';
% load('C:\Documents\SkolTech\CV_Course\holidays\SIFTsArrayHolidays');
% load('C:\Documents\SkolTech\CV_Course\holidays\IdsArrayHolidays');
toc
SIFTsNum=size(SIFTsArray,2);

NumOfImages=0;
FoldersNum=max(IdsArray(2,:));
for c=(1:FoldersNum)
    NumOfImages=NumOfImages+max(IdsArray(1,IdsArray(2,:)==c))-min(IdsArray(1,IdsArray(2,:)==c))+1;
end

querys2find=1;
averP=zeros(querys2find,1);
for kk=(1:querys2find)

    %% random query image
    FoldersAmount=max(IdsArray(2,:));
    [ Im, QueryPath, QitemName, FolderIn, listingId ] = RandomQueryImage( QueryFolder, FoldersAmount );
    inputIm=Im;
%     inputIm=imread(ImPath);
%     Im = imresize(inputIm, 1024.0/max(size(inputIm,1),size(inputIm,2)));
    %% Query SIFTs
    tic
    
    prePath='C:\Documents\SkolTech\CV_Course\holidays\Inria_SIFTs\siftgeo_jpg';
    ifJpg=strfind(QitemName,'jpg');
    QitemNameT=QitemName(1:(ifJpg-2));
    Path2SIFTs=strcat(prePath,num2str(FolderIn),'\',QitemNameT,'.siftgeo');
    [v, meta] = siftgeo_read (Path2SIFTs);
    v=v';
    querySIFTs=v;
    querySIFTsNum=size(querySIFTs,2);
    
    
%     Im = single(rgb2gray(Im)) ;
%     peak_thresh=5;
%     [queryFrames,querySIFTs] = vl_sift(Im,'PeakThresh', peak_thresh) ;
%     querySIFTsNum=size(querySIFTs,2);
%     display(querySIFTsNum);
%     querySIFTs=single(querySIFTs);
    % tt = sum(abs(querySIFTs));
    % [~, ind] = sort(tt);
    % querySIFTs=querySIFTs(:,ind);
    % a=querySIFTs(:,1:round(0.1*end));
    % b=querySIFTs(:,round(0.9*end):end);
    % querySIFTs=[a,b];
    toc
    % Exact Inria Search
    k=10; 
    SIFTsfrom=1000;
    N=min(SIFTsfrom,querySIFTsNum);
    
    % N=querySIFTsNum;
    answ=8;
    %% Ranking SIFTs
    if (N==SIFTsfrom)
        q=randi(size(querySIFTs,2),N);
        q=q(:,1);
        q=sort(q);
        i=1;
        while (i<=size(q,1)-1)
            curSIFT=q(i);
            nextSIFT=q(i+1);
            if (curSIFT==nextSIFT)
                    a=q((1:(i)),:);
                    b=q(((i+2):end),:);
                    q=[a; b];
                    continue;
            end
            i=i+1;
        end
        q=q';
        RankingSIFTs=querySIFTs(:,q(:));
        N=size(q,2);
        display(N);
    end
    %% SIFTs Ranking
    tic
    if (N<querySIFTsNum)
        [ kNN, kNNDist ] = kNNFunc( k, RankingSIFTs, SIFTsArray, N );
%         [ kNN,kNNDist ] = kNNFuncTrees( k, RankingSIFTs, trees, N );
    end
    if (N==querySIFTsNum)
        [ kNN, kNNDist ] = kNNFunc( k, querySIFTs, SIFTsArray, N );
%         [ kNN,kNNDist ] = kNNFuncTrees( k, querySIFTs, trees, N );
    end
    toc

    %% Images Ranking
    % kNN - numbers of SIFTs from dataset
    % kNNDist - distances to this SIFTs from query SIFT
    [ scores ] = ScoringFunc( NumOfImages,numSIFTs,kNN,kNNDist,IdsArray,k,N,querySIFTsNum  );

    [~, I] = sort((-scores(:,3)));
%     idx=I(1:answ);
    output=scores(I,:);
    i=1;
    
    while i<=(2*answ)
        nb=output(i,5);
        na=output(i,4);
        if (nb<0.2*na)
            a=output((1:(i-1)),:);
            b=output(((i+1):end),:);
            c=output(i,:);
            output=[a; b; c];
            continue;
        end
        i=i+1;
    end

    %% Visualization
    Crop1=[];
    Crop2=[];
    param=0;
    retrieved=cell(0);
    for i=(1:answ)
        c=output(i,1);
        folderPath=strcat(QueryFolder,num2str(c));
        listing = dir(folderPath);
        item=listing(output(i,2));
        itemName=item.name;
        itemPath=strcat(folderPath,'\',itemName);
    %     retrieved{end+1}=itemPath;
        out=imread(itemPath);
        SizeOut=size(out);
        hight=SizeOut(2);
        wight=SizeOut(1);
        out(wight:1024,:,:)=0;
        out(:,hight:1024,:)=0;
        if (param<4)
            Crop1=[Crop1; out];
        end
        if (param>=4)
            Crop2=[Crop2; out];
        end
        param=param+1;
    end

    Crop=[Crop1,Crop2];
    figure();
    imshow(Crop);
    drawnow();
    figure();
    imshow(inputIm);
    drawnow();

    %% Find relevant
    [ relevant ] = FindRelevant( QitemName,listingId,QueryFolder,FolderIn );
    %% Find precision and recall for given n
%     [~, I] = sort((-scores(:,3)));
%     output=scores(I,:);

    % retrieved=cell(0);
    % for i=(1:n)
    %     c=output(i,1);
    %     folderPath=strcat(QueryFolder,num2str(c));
    %     listing = dir(folderPath);
    %     item=listing(output(i,2));
    %     itemName=item.name;
    %     itemPath=strcat(folderPath,'\',itemName);
    %     retrieved{end+1}=itemPath;
    % end

    %% Average Precision
    % n=NumOfImages;
    % in=1;
    RelevantSize=size(relevant,2);
    counter=1;
    FoundK=zeros(NumOfImages,1);
    FoundAtK=0;
    precision=zeros(NumOfImages,1);
    recall=zeros(NumOfImages,1);
    while counter<=NumOfImages
        in=counter;
        n=counter;
        [ found ] = PRfunc( in,n,output,relevant );
        RetrievedSize=n;
        FoundK(counter,1)=found;
        FoundAtK=sum(FoundK(1:counter),1);
        precision(counter,1)=FoundAtK/RetrievedSize;
        recall(counter,1)=FoundAtK/RelevantSize;
        counter=counter+1;
    end

    aP=0;
    for i=(1:NumOfImages)
        if (i==1)
            aP=aP+precision(i,1)*recall(i,1);
        end
        if (i>1)
            aP=aP+precision(i,1)*(recall(i,1)-recall((i-1),1));
        end
    end

    display(aP);
    averP(kk,1)=aP;
    display(kk/querys2find*100);
end

maP=mean(averP);
display(maP);
answer=[k,SIFTsfrom,maP];






