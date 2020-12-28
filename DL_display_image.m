function DL_display_image(GG,out_mat);
% DL_display_image

% plot raw image with damage boundries overlain

% WAL3
% 12/27/2020


figure();
subplot(3,1,1);
imagesc(GG); 
title('Raw stained tissue');
axis('tight');
axis('off')


subplot(3,1,2);
hold on; 
imagesc(mean(GG,3)); 
colormap(gray);

%for i = 1:length(out_mat.B);  plot(out_mat.B{i}(:,2),out_mat.B{i}(:,1),'color', [0 .3 0 0.8],'lineWidth',1); end;
for i = 1:length(out_mat.B2);  plot(out_mat.B2{i}(:,2),out_mat.B2{i}(:,1),'color', [1 0 0 0.6],'lineWidth',1); end;
axis('tight');
axis('off')

set(gca,'YDir','reverse')
title(' Severe zone');

subplot(3,1,3);
hold on; 
imagesc(mean(GG,3)); 
colormap(gray);

for i = 1:length(out_mat.B);  plot(out_mat.B{i}(:,2),out_mat.B{i}(:,1),'color', [0 .3 0 0.8],'lineWidth',1); end;
%for i = 1:length(out_mat.B2);  plot(out_mat.B2{i}(:,2),out_mat.B2{i}(:,1),'color', [1 0 0 0.6],'lineWidth',1); end;
axis('tight');
axis('off')
set(gca,'YDir','reverse')
title(' Damaged zone');

