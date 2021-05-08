function [RGB1, out] = DL_ImageStrat(IM2);
%DL_ImageStrat.m 

% 'geo-plot' plotter for clustered data, and to create ( and save) imagew

% WAL3
% Dec 2018; Last revision: 12-Dec-2020

% Make an intensity matched overlay:
 figure();
  RGB1 = XMASS_tish(IM2(:,:,1),IM2(:,:,2),IM2(:,:,3));

% % get cross-section ( through UI input)
%  disp('Make a cross-section selection!');
% [x,y] = ginput(2);
% 
% hold on;
% plot(x,y,'LineWidth',5,'Color',[1 1 1]);
% 
% % make like 'thick'
% m = ((y(2)-y(1))/(x(2)-x(1))); % slope ( rise/run)
counter = 1;


% plot on top
I = getimage(gca);

for i = 1: 20; % change x and y by on
    % solve for y = mx+b
  y1(counter) = (round(m*(x(1)))+1*i);% increase 'b' by one...
  x1(counter) = (round(y1(1)/m));
  y1(counter) = -y1(counter);
  counter = counter+1;
  y1(counter) = (round(m*(x(2)))+1*i);
  x1(counter) = (round(y1(2)/m));
  y1(counter) = -y1(counter);
  counter = 1;
    temp = squeeze(improfile(I,x,y,1000));
  if i ==1;
  dat(:,:,i) = temp;
  else
  dat(:,:,i) = temp(1:size(dat,1),:);
  end
end




dat2 = mean(dat,3);
smth = 300; % smoothing factor
figure();
hold on;
 plot(smooth(dat2(:,1),smth),'r')
 plot(smooth(dat2(:,2),smth),'g')
 plot(smooth(dat2(:,3),smth),'b')



smooth_param = 10;% how much to spatially smooth

for i = 1:3;
C(:,:,i) =imgaussfilt(RGB1(:,:,i),smooth_param,'padding','circular');
end

% First, look at Blue vs Green
matA = C(:,:,2) - C(:,:,3);

figure();
subplot(3,1,1)
imshow(RGB1);
subplot(3,1,2)
h = imshow(RGB1);
alpha = (matA+0.2);
BW1 = imbinarize(matA);
alpha(alpha<0.25) = 0;
set(h, 'AlphaData', BW1);
subplot(3,1,3)
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
subplot(3,1,1)
imshow(RGB1);
subplot(3,1,2)
h = imshow(RGB1);
alpha = (matA+0.2);
BW1 = imbinarize(matA);
alpha(alpha<0.25) = 0;
set(h, 'AlphaData', BW1);
out.R = BW1;
subplot(3,1,3)
h2 = imshow(RGB1);
alpha = -(matA)+0.2;
alpha(alpha<0.3) = 0;
BW2 = imbinarize(alpha);
set(h2, 'AlphaData', alpha);
out.B = BW2;

% get ouptupts
for i = 1: 3
out.All(:,:,i) = imbinarize(C(:,:,i));
end

% Plot boundires
B2 = bwboundaries(BW1);

figure();
imagesc(RGB1);

hold on;
for i = 1:size(B2,1)
plot(B2{i}(:,2),B2{i}(:,1),'LineWidth',2,'Color',[1 1 1])
end
title('red and green overlap')

out.B = B;
out.B2 = B2;
