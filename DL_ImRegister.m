% Lung Damge Image registration

% 06/21/2020
% WAL3


% Load in data locally 

mov_listing=dir(fullfile(pwd,'*.TIF'));
mov_listing={mov_listing(:).name};
filenames=mov_listing;


for ii=1:length(mov_listing)
    % cut it out of the datastructure
    
    [path,file,ext]=fileparts(filenames{ii});
    FILE = fullfile(pwd,mov_listing{ii})
    % Load data from each folder
   IM{ii} =  imread(FILE);
   sizMat(ii,:) = size(IM{ii});
end

% pad to the largest cell array:
X = max(sizMat(:,1));
Y = max(sizMat(:,2));

for ii = 1:length(mov_listing);
    [xral, yral, zral] = size(IM{ii});
xdiff = X-xral;
ydiff = Y-yral;

temp = padarray(IM{ii},[xdiff/2 ydiff/2],'replicate');

ResizedIM(:,:,:,ii) = imresize(temp,0.1);
end


% Look at images
figure();
for i = 1: length(mov_listing)
 imagesc(squeeze(ResizedIM(:,:,:,i)));
     title('Unregistered Images');
 pause(1);
end


% Image Registraion!

% register:
clear optimizer
[optimizer, metric] = imregconfig('multimodal');
%optimizer = registration.optimizer.RegularStepGradientDescent;
optimizer.InitialRadius = 0.00009;
optimizer.Epsilon = 1.5e-4;
optimizer.GrowthFactor = 1.3;
optimizer.MaximumIterations = 300;
% optimizer.MaximumIterations = 30;
% optimizer.MinimumStepLength = 5e-4;
for i = 1: length(mov_listing)
    A = rgb2gray(ResizedIM(:,:,:,1));
    B = rgb2gray(ResizedIM(:,:,:,i));
%     B = imhistmatch(B,A);

     tform = imregtform(B, A , 'affine', optimizer, metric);
     for iii = 1:3
Registered(:,:,iii,i) = imwarp(squeeze(ResizedIM(:,:,iii,i)),tform,'OutputView',imref2d(size(A)));
     end
end




% Look at images
figure();
for i = 1: length(mov_listing)
 imagesc(squeeze(Registered(20:end-20,20:end-20,:,i)));
 title('aligned images');

 pause(1);
end


% view:
for i = 1:length(mov_listing);
X = Registered(20:end-20,20:end-20,:,i);
Y = Registered(20:end-20,20:end-20,:,1);
err(i) = immse(X,Y);
end
figure(); hold on; plot(err(1:end));plot(err(1:end),'*');
title('Mean squared error compared to first sample');
ylabel('MSE');
xlabel('Sample number');
set(gca,'xtick',1:length(mov_listing));

% % Run Image scripts on data, and stack...

% Plot data...
figure(); 
XMASS_tish(256-Registered(:,:,1,1),256-Registered(:,:,1,2),256-Registered(:,:,1,1),'hl',[0.5 0.95]);
title('aligned, adjacent slides');
figure(); 
XMASS_tish(256-ResizedIM(:,:,1,1),256-ResizedIM(:,:,1,2),256-ResizedIM(:,:,1,1),'hl',[0.5 0.95]);

title('un-aligned, adjacent slides');


