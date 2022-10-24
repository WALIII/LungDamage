function [IM2] = DL_ImageSegment(image2use);
% DL_ImageSegmentation.m

% Color-Based Segmentation Using K-Means Clustering for DCL's imaging data

% WAL3
% d08/27/18

% User input
nColors = 4; % how many clusters? Too many will cause convergence failure.
channels =  [1 2 3]; % what clusters to use for the composite?

% Load image(s)
if nargin<1 % if you don't pass the image as an argument, load from directory
    disp('select image in local directory...');
    
    [file,path] = uigetfile({'*.jpg';'*.png';'*.mat'},...
        'File Selector');
    if isequal(file,0)
        disp('User selected Cancel');
    else
        disp(['User selected ', fullfile(path,file)]);
    end
    currentfilename = file;
    currentimage = imread(currentfilename);
    image2use = currentimage;
end

% downsample if image is too large/ too big...
if size(image2use,1) > 3000;
    disp('image is very large- downsizing image')
    image2use = imresize(image2use,0.75);
end


% filter image:
image2use = double(image2use);
sigma = 2;% smooth
image2use = imgaussfilt(image2use,sigma,'padding','circular');% Filter the data


disp(' pre-processing image...');
% Pre-process Image
lab_he = rgb2lab(image2use);
ab = double(lab_he(:,:,2:3)); % for H&E, just take the G&B channel
%ab = double(lab_he(:,:,2:3)); % for H&E, just take the G&B channel
nrows = size(ab,1);
ncols = size(ab,2);
%ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);
%ab = reshape(ab,nrows*ncols,2);

disp('clustering data...');
% Repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
    'Replicates',3);

pixel_labels = reshape(cluster_idx,nrows,ncols);

disp('Plotting data...');
figure();
imshow(pixel_labels,[]), title('image labeled by cluster index');


% Assign some labels
g{1} = 'dead';
g{2} = 'damaged';
g{3} = 'healthy';

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = image2use;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

% export image data and sort channels by mean pixel value
for i = 1:nColors
    IM(:,:,i) = mean(segmented_images{i},3); % Store in a matrix
    IM_temp = IM(:,:,i); % store in sepreate matrix
    chan_srt(i) = mean(IM_temp(:)); clear IM_temp
end


[~,srtChan] = sort(chan_srt);

DL_PlotPixels(image2use,cluster_idx,srtChan);
for i = 1:nColors;
    IM2(:,:,i) = IM(:,:,srtChan(i));
end
clear IM;

