indexs = zeros();
count = 0;
for ind = 1:10000
    if mod(ind, 8) == 0
        count = count + 1;
        continue;
    else
        indexs(ind-count) = ind;
    end
end

for k =1:57
   
load(['mnt/gists/',folderOrder{k}]);

data1  = gistFeatures(1,:,index);
dataVec = zeros(512,0);

       for i=1:8750
           single = data1(1,:,i);
           dataVec = horzcat(dataVec, single');
       end
       save(['/mnt/gists/assignments/dataVectors/',folderOrder{k}], 'dataVec');
       cbase = pq_assign(pq, dataVec);
       save(['/mnt/gists/assignments/dataVectorsAssignment/',folderOrder{k}], 'cbase');
clear matrix;
end    