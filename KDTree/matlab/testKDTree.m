disp('##########################################################');
disp('----- advanced k-d tree -----');

dimNumber = 128;
maxLeafsVisited = 500;
pointsNumber = 2000;
valuesRange = 100;

aBigSet = randi(valuesRange, pointsNumber, dimNumber);
aBigSet(:, 1) = randi(pointsNumber, pointsNumber, 1);
aBigSet(:, 2) = randi(pointsNumber/2, pointsNumber, 1);
aBigSet(:, 7) = randi(pointsNumber, pointsNumber, 1);

disp('Building a tree'); 
tic;
bigTree = buildKDTree(aBigSet, single(1:size(aBigSet, 1)));
toc;
disp([' ']); 

for i = 1:3
    disp(['----- ' num2str(i) ' -----']); 
    point = aBigSet(15+i, :);

    disp('kd tree search'); 
    tic;
    [ bestPoint, bestDistance, resultStack, leafsVisited ]...
                    = searchKDTree(bigTree, point, maxLeafsVisited);    
    toc;
    disp([' ']);  

    disp('matrix vector multiplication search'); 
    tic;
    [ resultDistance, resultPoint ] = getClosestPoint(aBigSet, point);
    toc;
    disp([' ']); 
    
%     if ((bestDistance ~= resultDistance) | (bestPoint.point ~= resultPoint))
    if ((bestDistance ~= resultDistance))
       disp('Wrong result!!!'); 
    end    
end

