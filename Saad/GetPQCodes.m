
%This function returns set of PQ Codes of Given Image Indices
 function [PQ,ImgIdx] = GetPQCodes(IdxStruct,PQCodes,Idx) 
    PQ = [];
    ImgIdx = [];
    for i = 1:length(Idx)
       PQ  = [PQ PQCodes(:,PQStructs(i).startIndex:PQStructs(i).EndIndex)];
       total = PQStructs(i).EndIndex - PQStructs(i).startIndex +1;
       ImgIdx = [ImgIdx Idx(i)*ones(1,total)];
    end
 end
