
%This function returns set of PQ Codes of Given Image Indices
 function [PQ,ImgIdx] = GetPQCodes(IdxStruct,PQCodes,Idx) 
    PQ = [];
    ImgIdx = [];
    PQStructs = IdxStruct(Idx);
    for i = 1:length(Idx)
       PQ  = [PQ PQCodes(:,PQStructs(i).startIndex:PQStructs(i).EndIndex)];
       total = PQStructs(i).EndIndex - PQStructs(i).startIndex +1;
       ImgIdx = [ImgIdx Idx(i)*ones(1,total)];
    end
 end


%/mnt/Data/ProductQuantization/Data/IndxCombine.mat
%/mnt/Data/ProductQuantization/Data/PQStruct1.mat
%/mnt/Data/ProductQuantization/Data/PQStruct2.mat
%     for i = 1:100
%        prev = IndexStructs{i-1};
%        current = IndexStructs{i};
%        EndIdx = prev(length(prev)).EndIndex;
%        for j =1:length(current)
%          if j == 1
%              current(j).startIndex = current(j).startIndex + EndIdx;
%              current(j).EndIndex = current(j).startIndex + current(j).EndIndex;
%          else+
%              startIdx = current(j).startIndex;
%              current(j).startIndex = current(j-1).EndIndex + 1;
%              current(j).EndIndex = current(j-1).EndIndex + (current(j).EndIndex - startIdx);
%          end
%          
%        end
%        IndexStructs{i}= current;
%       end