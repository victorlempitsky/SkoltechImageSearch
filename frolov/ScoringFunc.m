function [ scores ] = ScoringFunc( NumOfImages,numSIFTs,kNN,kNNDist,IdsArray,k,N,querySIFTsNum  )

scores=zeros(NumOfImages,5);
scores(:,1:2)=numSIFTs(:,1:2);
% a=1;
% b=0;
% for c=(1:FoldersNum)
%     ImInFolder=max(IdsArray(1,IdsArray(2,:)==c))-min(IdsArray(1,IdsArray(2,:)==c))+1;
%     b=b+ImInFolder;
%     scores(a:b,1)=c;
%     scores(a:b,2)=min(IdsArray(1,IdsArray(2,:)==c)):max(IdsArray(1,IdsArray(2,:)==c));
%     a=b+1;
% end





matching=zeros(k*N,4);
mtch=0;
for i=(1:N)
%     qSIFT=RankingSIFTs(:,i);
    for j=(1:k)
        mtch=mtch+1;
        SIFTid=kNN(i,j);
        Folderid=IdsArray(2,SIFTid);
        Imageid=IdsArray(1,SIFTid);
        matching(mtch,1)=SIFTid;
        matching(mtch,2)=Folderid;
        matching(mtch,3)=Imageid;
        rowF=find(scores(:,1)==Folderid, 1 );
        row=rowF+(Imageid-scores(rowF,2));
        na=querySIFTsNum;
        nb=numSIFTs(row,3);
%         score=(max((kNNDist(i,k)-kNNDist(i,j)),0));
        score=(max((kNNDist(i,k)-kNNDist(i,j)),0))/(sqrt(na)*sqrt(nb));
%         score=(max((kNNDist(i,k)-kNNDist(i,j)),0))/((na)*(nb));
%         display(score); 
        matching(mtch,4)=score;
%         scores(row,3)=scores(row,3)+score;
%         scores(row,4)=na;
%         scores(row,5)=nb;
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
    Folderid=matching(i,2);
    Imageid=matching(i,3);
    rowF=find(scores(:,1)==Folderid, 1 );
    row=rowF+(Imageid-scores(rowF,2));
    na=querySIFTsNum;
    nb=numSIFTs(row,3);
%         score=(max((kNNDist(i,k)-kNNDist(i,j)),0));
%     score=(max((kNNDist(i,k)-kNNDist(i,j)),0))/(sqrt(na)*sqrt(nb));
%         display(score); 
    score=matching(i,4);
    scores(row,3)=scores(row,3)+score;
    scores(row,4)=na;
    scores(row,5)=nb;
end






% matching=zeros(1,k*N);
% mtch=0;
% for i=(1:N)
%     qSIFT=RankingSIFTs(:,i);
%     for j=(1:k)
%         SIFTid=kNN(i,j);
%         Folderid=IdsArray(2,SIFTid);
% %         display(Folderid);
%         Imageid=IdsArray(1,SIFTid);
%         if (all(matching(1:(mtch+1))~=SIFTid))
%             mtch=mtch+1;
%             matching(1,mtch)=SIFTid;
%     %         display(Imageid);
%             rowF=find(scores(:,1)==Folderid, 1 );
%             row=rowF+(Imageid-scores(rowF,2));
%             na=querySIFTsNum;
%             nb=numSIFTs(row,3);
%     %         score=(max((kNNDist(i,k)-kNNDist(i,j)),0));
%             score=(max((kNNDist(i,k)-kNNDist(i,j)),0))/(sqrt(na)*sqrt(nb));
%     %         display(score); 
%             scores(row,3)=scores(row,3)+score;
%             scores(row,4)=na;
%             scores(row,5)=nb;
%         end
%     end
% end


end

