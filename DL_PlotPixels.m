function DL_PlotPixels(image,cluster_idx,srtChan);

% WAL3
%  DL_PlotPixels(image,cluster_idx,srtChan);

% 
% image2 = imresize((image),0.2);

image2 = (mat2gray(image));
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

% % 
X1 = X1-min(X1)./(max(X1)-min(X1));
X2 = X2-min(X2)./(max(X2)-min(X2));
X3 = X3-min(X3)./(max(X3)-min(X3));

X_f(:,1) = X1;
X_f(:,2) = X2;
X_f(:,3) = X3;
%X_f(:,4) = 1:size(X3,1) ;


% normalize values
% 




figure();
grid on;
hold on;
N = 10;

for i = 1:4;
    
    idx = find(cluster_idx==srtChan(i));
    a = X1(idx(1:1:end));
    b = X2(idx(1:1:end));
    c = X3(idx(1:1:end));
    d = ones(size(c,1),1)*20'; % size
    A1 = a(1:N:end);
    B1 = b(1:N:end);
    C1 = c(1:N:end);
    D1 = d(1:N:end); % size
    XX = A1+B1+C1;
    scatter(C1./A1,B1./A1,D1, 'MarkerFaceColor',col(i,:) ,'MarkerEdgeColor',col(i,:),...
        'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',0);
    xlabel('Green/red');
    ylabel(' Blue/red');
end


title(' RGB pixel location');

out.red  = a;
out.green = b;
out.blue = c;

n2u = 500;

X_f2 = X_f;
% X_f2(:,4) = X1./X2;
% X_f2(:,5) = X3./X2;
% 
% X_f2(:,6) = X2./X1;
% X_f2(:,7) = X2./X3;
% 
% X_f2(:,8) = X3./X1;
% X_f2(:,9) = X3./X2;
% 
% X_f2(:,10) = X1.*X2;
% X_f2(:,11) = X1.*X3;
% X_f2(:,12) = X2.*X3;

Y = tsne(X_f(1:n2u:end,:));

figure(); 
hold on;
cluster_idx2 = cluster_idx(1:n2u:end);
for i = 1:4;
    idx = find(cluster_idx2==srtChan(i));
scatter(Y(idx,1),Y(idx,2),'MarkerFaceColor',col(i,:) ,'MarkerEdgeColor',col(i,:))
end


