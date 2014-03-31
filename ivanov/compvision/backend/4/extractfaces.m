function facestoreturn = extractfaces(img, model )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
faceDetector = vision.CascadeObjectDetector;
bboxes = step(faceDetector,img);
% imgfaces = img;
% imgfaces = insertObjectAnnotation(img, 'rectangle', bboxes,'Face');
% figure; imshow(imgfaces), title('Detected faces');hold on;

%% Transform to 160*125

% Detect nine facial landmarks
% a lot of external code here
det = [(bboxes(:,1)+bboxes(:,3)/2) (bboxes(:,2)+bboxes(:,3)/2) bboxes(:,3)/2];


% figure; imshow(img); hold on; scatter(pbest(1,:),pbest(2,:)); hold off;

%%
% close all;
sizex = 125;
sizey = 160;
facestoreturn = {};
for iFace = 1:size(det,1)
    [pbest,conf] = findparts(model,img,det(iFace,:));
    
    if conf<0
        continue;
    end

    v81 = [pbest(1,1)-pbest(1,8); pbest(2,1)-pbest(2,8)];
    v14 = [pbest(1,4)-pbest(1,1); pbest(2,4)-pbest(2,1)];
    v89 = [pbest(1,9)-pbest(1,8); pbest(2,9)-pbest(2,8)];

    v8 = [pbest(1,8);pbest(2,8)];

%     imgr = rgb2gray(img);

    lv = v81 +v14/2 - v89/2;
    fc = v8 + v89/2 + lv/2;
    wv = v14;
    incrx = 1.20/2;
    incry = 2.20/2;

    % pshow = fc - incry*lv - incrx*wv;
%     pshow = [(fc + incry*lv + incrx*wv) (fc -incry*lv + incrx*wv)...
%         (fc +incry*lv - incrx*wv) (fc -incry*lv - incrx*wv) fc];
    
%     imgfaces = insertObjectAnnotation(img, 'rectangle', bboxes(iFace,:),num2str(conf));
%     figure; imshow(imgfaces); 
    % hold on; 
%     scatter(pshow(1,:),pshow(2,:)); 
    % hold off;
    

    movingPoints = [(fc +incry*lv - incrx*wv) (fc +incry*lv + incrx*wv) (fc -incry*lv - incrx*wv) (fc -incry*lv + incrx*wv)]';
    fixedPoints = [1 1; sizey 1;1 sizex; sizey sizex];
    % tform = fitgeotrans(movingPoints,fixedPoints,'NonreflectiveSimilarity');
    tform = fitgeotrans(movingPoints,fixedPoints,'NonreflectiveSimilarity');

    maxwl = max(abs([incry*lv incrx*wv]'))';
    unrotface = imcrop(img, [(fc - 2*maxwl) 4*maxwl]);

    Jregistered = imwarp(unrotface,tform);
    a = size(Jregistered); a = [a(2) a(1)]/2; b = [62 79.5]; b1 = [62 -79.5];

    I2 = imcrop(Jregistered,[(a-b) 2*b]);
%     figure;
%     imshow(I2);
    
    facestoreturn = [facestoreturn I2];
end

end

