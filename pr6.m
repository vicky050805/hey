lo
ad woman;
image(X)
title('Original Image')
colormap(map)

n = 5; % Decomposition Level
w = 'sym8'; % Near symmetric wavelet
[c l] = wavedec2(X,n,w); % Multilevel 2-D wavelet decomposition.
opt = 'gbl'; % Global threshold
thr = 20; % Threshold
sorh = 'h'; % Hard thresholding
keepapp = 1; % Approximation coefficients cannot be thresholded
[xd,cxd,lxd,perf0,perfl2] = wdencmp(opt,c,l,w,n,thr,sorh,keepapp);  
image(X)
title('Original Image')
colormap(map)
figure('Color','white'),image(xd)
title('Compressed Image - Global Threshold = 20')
colormap(map)

perf0
76.2099

perfl2
99.9772