% Lung Damge Image registration

% 06/21/2020
% WAL3


% Load in data 

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

ResizedIM(:,:,:,ii) = temp;
end


% Look at images
figure();
for i = 1: length(mov_listing)
 imagesc(squeeze(ResizedIM(:,:,:,i)));
 pause(1);
end


% Image Registraion!

% register:
clear optimizer
[optimizer, metric] = imregconfig('monomodal');
%optimizer = registration.optimizer.RegularStepGradientDescent;
%  optimizer.InitialRadius = 0.09;
% optimizer.Epsilon = 1.5e-2;
%optimizer.GrowthFactor = 1.05;
optimizer.MaximumIterations = 30;
% optimizer.MinimumStepLength = 5e-4;
for i = 1: length(mov_listing)
    A = rgb2gray(ResizedIM(:,:,:,1));
    B = rgb2gray(ResizedIM(:,:,:,i));
%     B = imhistmatch(B,A);

     tform = imregtform(B, A , 'similarity', optimizer, metric);
     for iii = 1:3
Registered(:,:,iii,i) = imwarp(squeeze(ResizedIM(:,:,iii,i)),tform,'OutputView',imref2d(size(A)));
     end
end




% Look at images
figure();
for i = 1: length(mov_listing)
 imagesc(squeeze(Registered(:,:,:,i)));
 title('aligned images');

 pause(1);
end


% view:


% % Run Image scripts on data, and stack...

