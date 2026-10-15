I=imread('image1.jpg');
imshow(I),title('Original Image');

h=rgb2gray(I);
figure,imshow(h),title('Gray Image');

h=imadjust(h,stretchlim(h),[0,1]);
figure,imshow(h),title('Stretching image');

h1=imadjust(h,[0,1],[1,0]);
figure,imshow(h1),title('Negative');

LEN = 31;
THETA = 11;
PSF = fspecial('motion',LEN,THETA); % create PSF
Blurred = imfilter(I,PSF,'circular','conv');
figure,imshow(Blurred); title('Blurred Image');

background = imopen(I,strel('disk',15));
Ip = imsubtract(I,background);
figure,imshow(Ip,[]),title('Background Subtraction');

Iq = imsubtract(I,50);
figure,imshow(Iq),title('Subtracted Image');