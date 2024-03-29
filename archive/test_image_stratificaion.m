function RGB1 = test_image_stratificaion(IM_B);% Derek's 'geo-plot' plotter

% Create ( and save) image
 % Make an intensity matched overlay:
 figure(); 
  XMASS_song(IM2(:,:,1),IM2(:,:,2),IM2(:,:,3));
  
  
 disp('Make a selection!'); 

% get cross-section ( through UI input)
[x,y] = ginput(2);

hold on;
plot(x,y,'LineWidth',5,'Color',[1 1 1]);

% make like 'thick'
m = ((y(2)-y(1))/(x(2)-x(1))); % slope ( rise/run)
counter = 1;


% plot on top 
I = getimage(gca);

figure(); 
for i = 1: 20; % change x and y by on
    % solve for y
  y1(counter) = (round(m*(x(1)))+1*i);
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
plot(x1,y1);
hold on;

end

    



% Pull pixel values for image ( stepwise for each channel?)


dat2 = mean(dat,3);
% make layerd plot or wtf this is called...

smth = 300; % smoothing factor
figure();
hold on;
 plot(smooth(dat2(:,1),smth),'r')
 plot(smooth(dat2(:,2),smth),'g')
 plot(smooth(dat2(:,3),smth),'b')
 
 
 % 
 

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



 