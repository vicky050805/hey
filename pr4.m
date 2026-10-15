i=imread('image5.jpg');
figure,imshow(i),title('Original image');

g=rgb2gray(i);
figure,imshow(g),title('Gray image');

j=imnoise(g,'Gaussian');
figure,imshow(j),title('Adding Gaussian noise in image');

h = ones(5,5)/25;
rgb2 = imfilter(i,h);
figure, imshow(rgb2),title('filtered image');

r=ordfilt2(j,median(1:3*3),ones(3,3));
figure,imshow(r),title('Median Filter');

K=filter2(fspecial('average',3),j)/255;
figure,imshow(K),title('Average filter');

s=wiener2(j,[5 5 ]);
figure,imshow(s),title('wiener(Adaptive) filter');

h = fspecial('unsharp');
I2 = imfilter(g,h);
figure, imshow(I2), title('Unsharpening Filter Image')

h=fspecial('gaussian');
I3=imfilter(g,h);
figure,imshow(I3),title('Gaussian low pass filter');