function out = DL_demo_ref(reference,varargin)
%DL_demo_ref.m - Plug-and-play Demo script to classify tussue damage for
%                multiple imagesmultiple images
%Run in a folder with the images you want to process.
%
%
% Syntax:  out = DL_demo_ref(REFERENCE)
%
% Inputs:
%    reference - name of referance image in local directory
% Optional Inputs:
%    type = image type (supports: PNG, jpeg)
%
% Outputs:
%    PcentR - Percent of severly damaged tissue
%    PcentG - Percent of moderatly damaged tissue
%    PcentG - Percent of normal tissue
%    RGB_out = RGB image for each tissue image
%
% Example:
%    out = DL_demo_ref('S copy.jpg')
%    out = DL_demo_ref('S copy.png','type',png)
%    out = DL_demo_ref('S copy.png','type',png,'sigma',5)% optional filtering
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: OTHER_FUNCTION_NAME1,  OTHER_FUNCTION_NAME2

% Author: William Liberti (WAL3)
% Work address: UC Berkeley
% email: bliberti@bu.edu
% Website: http://www.WALIII.github.io
% Dec 2019; Last revision: 12-Dec-2020

%------------- BEGIN CODE --------------

% default params
image_type = '*.jpg';
sigma = 5; % filtering kernal

% Manual inputs
vin=varargin;
for i=1:length(vin)
    if isequal(vin{i},'type') % image type to pull from local directory
        image_type=vin{i+1};
    elseif isequal(vin{i},'filer_sigma') % filter radius ( reduce for small images);
        sigma = vin{i+1};
    elseif isequal(vin{i},'normalize')
        normalize = vin{i+1};
    end
end


mov_listing=dir(fullfile(pwd,image_type));
mov_listing={mov_listing(:).name};
filenames=mov_listing;

filenames = erase(filenames,reference);
filenames = filenames(~cellfun('isempty',filenames));
RefIm = imread(reference);
horz_save(1) = size(RefIm,2); % get size reference

for i=1:length(filenames)
    RGB2 = imread(filenames{i});
    RGB2 = imresize(RGB2,size(RefIm,1)./size(RGB2,1));

    % concatenate images
    if i ==1;
        GG = cat(2,RefIm,RGB2);
    else
        GG = cat(2,GG,RGB2);
    end
    horz_save(i+1) = size(GG,2);
    clear RGB2
end

% Display iamges
figure(); imshow(GG)

% Segment images...
[IM2] = DL_ImageSegment(GG);

[RGB1, out_mat] = DL_ImageStrat(IM2);

RGB2 = mat2gray(RGB1); % normalize images


% Filter the data
RGB3 = imgaussfilt(RGB1,sigma,'padding','circular');


A1 = [1,horz_save];%1: ((size(RGB2,2)-1)/3): size(RGB2,2); % breakdown size of im matrix
for i = 1:(length(filenames)+1);

    [HH1 HH2] = max(RGB3,[],3);

    HH2(mean(RGB2(:,:,:),3)<0.001) = NaN;

    RIm{i} = HH2(:,A1(i):A1(i+1),1);
    GIm{i} = HH2(:,A1(i):A1(i+1),1);
    BIm{i} = HH2(:,A1(i):A1(i+1),1);

    RGB_out{i} = RGB2(:,A1(i):A1(i+1),:);

    RIm2{i} = sum(find(RIm{i}==1));
    GIm2{i} = sum(find(GIm{i}==2));
    BIm2{i} = sum(find(BIm{i}==3));
    PcentR(i) = RIm2{i}/(RIm2{i}+GIm2{i}+BIm2{i});
    PcentG(i) = GIm2{i}/(RIm2{i}+GIm2{i}+BIm2{i});
    PcentB(i) = BIm2{i}/(RIm2{i}+GIm2{i}+BIm2{i});
    data(:,i) = [PcentB(i),PcentG(i),PcentR(i)];

    % Create similarity Score to reference ( first ) image:

end

figure();
b = bar(data'*100,'stacked');
b(1).FaceColor = 'blue';
b(2).FaceColor = 'green';
b(3).FaceColor = 'red';
legend('normal', 'moderate','damaged');
ylabel('Percent of tissue');
xlabel('Sample');

% output data matrix:
out.PcentR = PcentR*100;
out.PcentG = PcentG*100;
out.PcentB = PcentB*100;

% output damage masks for each input image
out.RGB_out = RGB_out;


% export .tif images for analysis in Fiji
mkdir('clustered_images');
for i = 1:length(RGB_out);
    if i ==1
        imwrite(RGB_out{i},['clustered_images/',reference(1:end-4),'_clustered.tif'])

    else
        imwrite(RGB_out{i},['clustered_images/',filenames{i-1}(1:end-4),'_clustered.tif'])
    end
end
DL_display_image(GG,out_mat);
saveas(gcf, ['clustered_images/','Bounded_Images','_clustered.tif'])
