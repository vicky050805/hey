i=imread('image3.jpg');
j=rgb2gray(i);
g1=edge(j,'sobel');
g2=edge(j,'prewitt');
g3=edge(j,'roberts');
subplot(2,2,1)
imshow(i);
title('Original Image');
subplot(2,2,2)
imshow(g1);
title('Edge Detection using Sobel');
subplot(2,2,3)
imshow(g2);
title('Edge Detection using Prewitt');
subplot(2,2,4);
imshow(g3);
title('Edge Detection using Roberts')

t=graythresh(j);
f=mat2gray(j);
gt=(f>=t);
figure,imshow(gt);
title('Global Thresholding');

[H,theta,rho]=hough(g1);
h=mat2gray(H);
figure,imshow(imadjust(h),[],...
'XData',theta,...
'YData',rho,...
'InitialMagnification','fit');
title('Hough Transform');
xlael('\theta(degress)')
ylabel('\rho')
axisnormal
holdon
colormap(hot)