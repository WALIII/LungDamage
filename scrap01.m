
function scrap01(RGB1)



smooth_param = 10;

for i = 1:3;
C(:,:,i) =imgaussfilt(RGB1(:,:,i),10,'padding','circular');
end

% First, look at Blue vs Green
matA = C(:,:,2) - C(:,:,3);


figure();
subplot(1,3,1)
imshow(RGB1);
subplot(1,3,2)
h = imshow(RGB1);
alpha = (matA+0.2);
BW1 = imbinarize(matA);
alpha(alpha<0.25) = 0;
set(h, 'AlphaData', BW1);
subplot(1,3,3)
h2 = imshow(RGB1);
alpha = -(matA)+0.2; 
alpha(alpha<0.3) = 0;
BW2 = imbinarize(alpha);
set(h2, 'AlphaData', alpha);



% Plot boundires 
B = bwboundaries(BW1);

figure(); 
imagesc(RGB1);

hold on;
for i = 1:size(B,1)
plot(B{i}(:,2),B{i}(:,1),'LineWidth',2,'Color',[1 1 1])
end

title('blue and green overlap');


% next, Green vs Red...
clear matA
matA = C(:,:,1) - C(:,:,2);


figure();
subplot(1,3,1)
imshow(RGB1);
subplot(1,3,2)
h = imshow(RGB1);
alpha = (matA+0.2);
BW1 = imbinarize(matA);
alpha(alpha<0.25) = 0;
set(h, 'AlphaData', BW1);
subplot(1,3,3)
h2 = imshow(RGB1);
alpha = -(matA)+0.2; 
alpha(alpha<0.3) = 0;
BW2 = imbinarize(alpha);
set(h2, 'AlphaData', alpha);



% Plot boundires 
B2 = bwboundaries(BW1);

figure(); 
imagesc(RGB1);

hold on;
for i = 1:size(B2,1)
plot(B2{i}(:,2),B2{i}(:,1),'LineWidth',2,'Color',[1 1 1])
end
title('red and green overlap')




