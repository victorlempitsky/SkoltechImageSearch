% this file loads the data vectors, quauntizations, and search for the
% given query, 
%
% for indexing

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

dataset = 'gist';
pq_test_load_vectors;


k = 100;             % number of elements to be returned
m = 8;             % number of subquantizers to be used (m in the paper)




bestMatch =zeros();
dist = zeros(1,0);
idxx = zeros(1,0);
test = zeros(0,0)
imageNames = cell(300,1);
    
count = 1;

for index = 1:57
    t0 = cputime;
    cbase = load(['/mnt/gists/assignments/dataVectorsAssignment/',folderOrder{index}]);
    [ids_pqc, dis_pqc] = pq_search (pq, cbase.cbase, fquery, 5);
    tpq = cputime - t0;
    folder = '1/';
%    for o = 1:5
% %      
%          imageNumber = indexs(ids_pqc(o));
%          dirs='/mnt/Images/'; 
% %         
% %           path(dirs,path);
% %         files=dir(dirs);
% 
%         if index == 1 | index == 2 | index == 3 | index == 4 | index == 8 | index == 9 | index == 10 | index == 12 |index == 14 | index == 52 
%         dirs='/mnt/Images/13'; 
%          folder = '13/';
%          for o = 1:5
% %      
%          imageNumber = indexs(ids_pqc(o));
% %          imageNames{o} = ['/mnt/Images/13/',files(imageNumber).name];
%          imageNames{o} = imageNumber;
% 
%          end
%         
%         elseif index == 5 | index == 16 | index == 18 | index == 19 | index == 22 | index == 23 | index == 56 | index == 45 
%         dirs='/mnt/Images/15'; 
%            folder = '15/';
%              for o = 1:5
% %      
%             imageNumber = indexs(ids_pqc(o));
%             imageNames{o+5} = imageNumber; %['/mnt/Images/17/',files(imageNumber).name];
% 
%          end
%         elseif index == 25 | index == 26 | index == 27 | index == 28 | index == 29 | index == 32 | index == 35 | index == 37 |index == 39 | index == 6 | index == 17
%         dirs='/mnt/Images/17'; 
%            folder = '17/';
%             for o = 1:5
% %      
%          imageNumber = indexs(ids_pqc(o));
%          imageNames{o+10} =imageNumber; % ['/mnt/Images/17/',files(imageNumber).name];
% 
%          end
%         elseif index == 7 | index == 30 | index == 31 | index == 42 | index == 44 | index == 48 | index == 51
%         dirs='/mnt/Images/60';
%            folder = '60/';
%          for o = 1:5
% %      
%          imageNumber = indexs(ids_pqc(o));
%          imageNames{o+15} =imageNumber; % ['/mnt/Images/60/',files(imageNumber).name];
% 
%          end
%         elseif index == 11 | index == 21 | index == 32 | index == 36 | index == 50 | index == 53
%         dirs='/mnt/Images/62'; 
%    folder = '62/';
%             for o = 1:5
% %      
%          imageNumber = indexs(ids_pqc(o));
%          imageNames{o+20} = imageNumber; %['/mnt/Images/62/',files(imageNumber).name];
% 
%          end
%         elseif index == 13 | index == 38  
%         dirs='/mnt/Images/68'; 
%            folder = '68/';
%            for o = 1:5
% %      
%          imageNumber = indexs(ids_pqc(o));
%          imageNames{o+25} = imageNumber; %['/mnt/Images/68/',files(imageNumber).name];
% 
%          end
% 
%         elseif index == 15 | index == 24 || index == 40 | index == 49
%         dirs='/mnt/Images/70'; 
%            folder = '70/';
%            for o = 1:5
% %      
%          imageNumber = indexs(ids_pqc(o));
%          imageNames{o+30} =imageNumber; % ['/mnt/Images/70/',files(imageNumber).name];
% 
%          end
% 
%         elseif index == 57
%         dirs='/mnt/Images/23';
%         for o = 1:5
% %      
%          imageNumber = indexs(ids_pqc(o));
%          imageNames{o+35} = imageNumber; %['/mnt/Images/23/',files(imageNumber).name];
% 
%          end
%            folder = '23/';
% 
%         elseif index == 54 | index == 34 | index == 20
%         dirs='/mnt/Images/6'; 
%            folder = '6/';
%         for o = 1:5
% %      
%          imageNumber = indexs(ids_pqc(o));
%          imageNames{o+40} =imageNumber; % ['/mnt/Images/6/',files(imageNumber).name];
% 
%          end
%         end


       
%       imageNames{count} = ['/mnt/Images//',files(imageNumber).name];
%       count= count +1;
% %         copyfile(['/mnt/Images/',folder,files(imageNumber).name], '/mnt/gists/results/')
%     end
%     baseV = load(['/mnt/gists/assignments/dataVectors/',folderOrder{index}]);
%     image = baseV.dataVec(:,ids_pqc(1));
%     
%     origional = load(['/mnt/gists/',folderOrder{index}]);

%     [tf, ii] = ismember(origional.matrix, image)
%     imageNumber = ii(512)/512;
    
    idxx = vertcat(idxx, ids_pqc);
    dist = vertcat(dist,dis_pqc);
    clear ids_pqc;
    clear dis_pqc;
    
end
