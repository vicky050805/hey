f=imread('image4.jpg');
imshow(f);
title('Original image');

g=rgb2gray(f);
i=histeq(g);
g2=adapthisteq(g,'Numtiles',[25,25],'Cliplimit',0.05);
subplot(2,2,1);
imshow(g);
title('Gray image');
subplot(2,2,2);
imhist(i);
title('histrogram');
subplot(2,2,3);
imshow(g2);
title('Adapt Equalization');
subplot(2,2,4);
imhist(g2);
title('Adapt Equalization histogram');

k=histeq(g,256);
subplot(1,2,1);
imshow(k);
title('Histogram matching');
subplot(1,2,2);
imhist(k);