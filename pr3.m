i=imread('image3.jpg');
j=rgb2gray(i);
f=imnoise(j,'Salt & Pepper');
g=filter2(fspecial('average',3),f)/255;
g1=ordfilt2(f,median(1:3*3),ones(3,3));
subplot(2,2,1);
imshow(i);
title('Original Image');
subplot(2,2,2);
imshow(f);
title('Noise Image');
subplot(2,2,3);
imshow(g);
title('Average Filter');
subplot(2,2,4);
imshow(g1);
title('Median Filter');


LEN = 31;
THETA = 11;
PSF = fspecial('motion',LEN,THETA);
Blurred = imfilter(i,PSF,'circular','conv');
figure; imshow(Blurred);title('Blurred Image');

wnr1 = deconvwnr(Blurred,PSF);
figure;imshow(wnr1);
title('Restored, True PSF');