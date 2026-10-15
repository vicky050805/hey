i=imread('thalaiva.jpg');
imshow(i);
title('Original image');

i=rgb2gray(i);
figure,imshow(i);
title('gray image');

i=imresize(i,[250,255]);
figure,imshow(i);
title('Resize the image');

h3=imadjust(i,[],[],1);
h=imadjust(i,stretchlim(i),[0,1]);
h1=imadjust(i,[0,1],[1,0]);
h2=imadjust(i,[0.05,0.75],[0,1]); 
subplot(2,2,1);
imshow(h3);
title('enhancement');
subplot(2,2,2);
imshow(h);
title('Stretching image');
subplot(2,2,3);
imshow(h1);
title('negative');
subplot(2,2,4);
imshow(h2);
title('intensity');