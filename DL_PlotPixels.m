function DL_PlotPixels(image,cluster_idx,srtChan);



image2 = mat2gray(image);


% run clustering


col(1,:) = [1,0,0];
col(2,:) = [0,1,0];
col(3,:) = [0,0,1];
col(4,:) = [1,0,1];


figure();
% plot RGB in loop
clear X1 X2 X3



% 


X1(:,:) =   (double(image2(:,:,1)));
X1 = X1(:);
X2(:,:) =   (double(image2(:,:,2)));
X2 = X2(:);
X3(:,:) =   (double(image2(:,:,3)));
X3 = X3(:);


figure();
grid on;
hold on;


for i = 1:4;
    
    idx = find(cluster_idx==srtChan(i));
    a = X1(idx(1:80:end));
    b = X2(idx(1:80:end));
    c = X3(idx(1:80:end));
    d = ones(size(c,1),1)*2';
    scatter3(a,b,c,d,'MarkerFaceColor',col(i,:) ,'MarkerEdgeColor',col(i,:),...
        'MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.1);
end


title(' RGB pixel location');

out.red  = a;
out.green = b;
out.blue = c;


