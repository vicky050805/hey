i=imread('thalaiva.jpg');
imshow(i),title('Original image');
f=rgb2gray(i);
figure,imshow(f),title('Gray image');
noise_g = imnoise(f,'Salt & Pepper');
figure,imshow(noise_g),title('Salt & Pepper noise');
r=ordfilt2(noise_g,median(1:3*3),ones(3,3));
figure,imshow(r),title('Median Filter')
t=graythresh(f);
f=mat2gray(f);
gt = (f>=t);
figure,imshow(gt),title('Global Thresholding');
f1=imopen(f,strel('disk',20));
figure,imshow(f1),title('Test image with disk of radius 20');
t=graythresh(f1);
f1=mat2gray(f1);
s=f1+t; local_thres = (f>=s);
figure,imshow(local_thres),title('LocaThresolding'); 
L = watershed(f);
Lrgb = label2rgb(L);
figure, imshow(Lrgb), title('Watershed');
w1 = [-1 -1 2;-1 2 -1;2 -1 -1]; % for line inclined at +45 degree
w2 = [2 -1 -1;-1 2 -1;-1 -1 2]; % for lines inclined at -45 degree
w3 = [-1 -1 -1;2 2 2;-1 -1 -1]; % for horizontal
w4 = [-1 2 -1;-1 2 -1;-1 2 -1]; % for vertical lines
g = imfilter(f,w1);
g = imfilter(f,w2);
g = imfilter(f,w3);
g = imfilter(f,w4);
subplot(2,2,1);
imshow(g),title('Filter on W1');
subplot(2,2,2);
imshow(g), title('Filter on W2');
subplot(2,2,3); imshow(g), title('Filter on W3');
subplot(2,2,4); imshow(g), title('Filter on W4');
k=edge(g,'sobel','vertical');
figure,imshow(k),title('Line detection on Vertical Line');
k=edge(g,'sobel','horizontal');
figure,imshow(k),title('Line detection on horizontical line');
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
d=imdilate(f,[se90 se0]);
figure,imshow(d),title('Dilated image');
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
d=imdilate(f,[se90 se0]);
d= imfill(d, 'holes');
figure, imshow(BWdfill),title('binary image with filled holes');
BWnobord = imclearborder(BWdfill, 4);
figure, imshow(BWnobord), title('cleared border image');
seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
figure, imshow(BWfinal), title('Extraction of Erosion');
BWao = bwareaopen(BWfinal,5000);
BWoutline = bwperim(BWao);
Segout = f;
Segout(BWoutline) = 255;
figure, imshow(Segout), title('Segmented Image'); 