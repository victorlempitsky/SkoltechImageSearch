path='C:\Documents\SkolTech\CV_Course\Equus_burchellii_1.jpg';
I=imread(path);

% I = vl_impattern('roofs1') ;
I = rgb2gray(I) ;
I=double(I);
% imshow(I) ;

% g=[-1/8 -1/8 -1/8;
%    -1/8 0 -1/8;
%    -1/8 -1/8 -1/8;
%     ];

g=[0 0.5 -0.5;
   0 0.5 -0.5;
   0 0.5 -0.5;
    ];

% g=[0 0 0;
%    1 0 -1;
%    0 0 0;
%     ];

% g=uint8(g);
% g=single(g);
% imshow(g);
A=zeros(533,802);
A(:,:)=-128;
% 
h=conv2(I,g);
h=h-A;
h=uint8(h);
% 
imshow(h);