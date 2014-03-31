function [ scores ] = ScoringFunc( NumOfImages,kNN,kNNDist,k,N,querySIFTsNum,ixs,ImgIndx,nb   )


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



scores=zeros(NumOfImages,4);
scores(:,1)=ixs;
scores(:,2)=querySIFTsNum;
scores(:,3)=nb;

matching=zeros(k*N,4);
mtch=0;
for i=(1:N)
    for j=(1:k)
        mtch=mtch+1;
        SIFTid=kNN(i,j);
        Imageid=ImgIndx(1,SIFTid);
        matching(mtch,1)=SIFTid;
        matching(mtch,2)=Imageid;
        row=find(scores(:,1)==Imageid);
        score=(max((kNNDist(i,k)-kNNDist(i,j)),0))/(sqrt(scores(row,2))*sqrt(scores(row,3)));
        matching(mtch,4)=score;
    end
end

[~, I] = sort((-matching(:,1)));
matching=matching(I,:);
i=1;

while (i<=size(matching,1)-1)
    curSIFT=matching(i,1);
    nextSIFT=matching((i+1),1);
    if (curSIFT==nextSIFT)
        curscore=matching(i,4);
        nextscore=matching((i+1),4);
        if (nextscore>=curscore)
            a=matching((1:(i-1)),:);
            b=matching(((i+1):end),:);
            matching=[a; b];
            continue;
        end
        if (nextscore<curscore)
            a=matching((1:(i)),:);
            b=matching(((i+2):end),:);
            matching=[a; b];
            continue;
        end
    end
    i=i+1;
end

for i=(1:size(matching,1))
    Imageid=matching(i,2);
    rowF=find(scores(:,1)==Imageid);
    score=matching(i,4);
    scores(rowF,4)=scores(rowF,4)+score;
end





end






















