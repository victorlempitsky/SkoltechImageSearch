directory = '/mnt/gists/';
path (directory, path);
featureFiles = dir(directory);

testTrain= zeros();
data = zeros();

matching = zeros(10000,0);
indexs = zeros();
realIndex = zeros();
count = 0;
for ind = 1:10000

    if mod(ind, 8) == 0
        count = count + 1;
        continue;
    else
        indexs(ind-count) = ind;
        if ind-count == 781
            disp('here');
        end
    end
    realIndex(ind) = ind;
end



for i=1:7
   a= baseV.dataVec(:,1) - origional.matrix(1,:,i)'
   if a == 0
       disp('yes');
   end
end


index = int32(indexs);
folderOrder = cell(100,1);
badfiles = cell(100,1);

first = 1;
for i= 3:size(featureFiles)
    try
    load(featureFiles(i).name);
    catch exception
        disp('Bad file format!');
        continue
    end
        
    f= matrix;
    tempTrain = zeros();
    tempData = zeros();
    
    
    
    if isempty(f) | f(:,:,350) == 0
        disp('Not valid');
        disp(featureFiles(i).name);
        badfiles{i-2} = featureFiles(i).name;

    else
        folderOrder{i-2} = featureFiles(i).name;
         dataVec = zeros(512,0);

       for i=1:8750
           single = data1(1,:,i);
           dataVec = horzcat(dataVec, single');
       end
       save('/mnt/gists/', 'dataVec');
       
% 
%         tempTrain = matrix(1,:,1:8:end);
%         tempData = matrix(1,:,index);
%         
%         if first == 1
%             
%             first = 2;  
%             testTrain = tempTrain
%             data = tempData;
% 
%         else
%             testTrain = vertcat(testTrain,tempTrain);
%             data = vertcat(data,tempData);
%          end
    end
end
