function out = DL_demo_ref(reference)
% Plug and play... just run in a folder with the image you want.

mov_listing=dir(fullfile(pwd,'*.jpg'));
mov_listing={mov_listing(:).name};
filenames=mov_listing;

filenames = erase(filenames,reference);
filenames = filenames(~cellfun('isempty',filenames));
RefIm = imread(reference);
horz_save(1) = size(RefIm,2); % get size reference

for i=1:length(filenames)
RGB2 = imread(filenames{i});
RGB2 = imresize(RGB2,size(RefIm,1)./size(RGB2,1));
% concatonate Images
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


[IM2] = DL_ImageSegment(GG);


[RGB1, out_mat] = DL_ImageStrat(IM2);


RGB2 = mat2gray(RGB1);


sigma = 5;
% RGB2 = imgaussfilt(RGB1,sigma);

RGB3 = imgaussfilt(RGB1,sigma,'padding','circular');% Filter the data 


A1 = [1,horz_save];%1: ((size(RGB2,2)-1)/3): size(RGB2,2); % breakdown size of im matrix
for i = 1:(length(filenames)+1);

    [HH1 HH2] = max(RGB3,[],3);
    
    HH2(mean(RGB2(:,:,:),3)<0.001) = NaN;

    RIm{i} = HH2(:,A1(i):A1(i+1),1);
    GIm{i} = HH2(:,A1(i):A1(i+1),1);
    BIm{i} = HH2(:,A1(i):A1(i+1),1);
    
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
legend('healthy', 'moderate','damaged');
ylabel('Percent of tissue');
xlabel('Sample');



% output data matrix:
out.PcentR = PcentR*100;
out.PcentG = PcentG*100;
out.PcentB = PcentB*100;





