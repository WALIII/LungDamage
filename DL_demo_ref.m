function DL_demo_ref(reference)
% Plug and play... just run in a folder with the image you want.

mov_listing=dir(fullfile(pwd,'*.jpg'));
mov_listing={mov_listing(:).name};
filenames=mov_listing;

filenames = erase(filenames,reference);
filenames = filenames(~cellfun('isempty',filenames));
RefIm = imread(reference);

for i=1:length(filenames)
RGB2 = imread(filenames{i});
RGB2 = imresize(RGB2,size(RefIm,1)./size(RGB2,1));

% concatonate Images
if i ==1;
GG = cat(2,RefIm,RGB2);
else
    GG = cat(2,GG,RGB2);
end
clear RGB2
end

% Display iamges
figure(); imshow(GG)


[IM2] = DL_ImageSegment(GG);


[RGB1, out] = DL_ImageStrat(IM2);

% Calculate precentages:

A = 1: (size(IM2,2)/3)-1: size(IM2,2); % breakdown size of im matrix
for i = 1:3
    FullIm{i} = out.B(:,A(i):A(i+1)) +out.R(:,A(i):A(i+1));
    RIm{i} = out.R(:,A(i):A(i+1));
    BIm{i} = out.B(:,A(i):A(i+1));
    PcentR(i) = sum(RIm{i}(:))./sum(FullIm{i}(:));
    PcentB(i) = sum(BIm{i}(:))./sum(FullIm{i}(:));
    data(i,:) = [PcentB(i), PcentR(i)];
end


% RGB2 = mat2gray(RGB1);
% 
% A1 = 1: (size(IM2,2)/3)-1: size(IM2,2); % breakdown size of im matrix
% for i = 1:3
%     FullIm{i} = RGB2(:,A1(i):A1(i+1),1) + RGB2(:,A1(i):A1(i+1),2) + RGB2(:,A1(i):A1(i+1),3);
%     RIm{i} = RGB2(:,A1(i):A1(i+1),1);
%     GIm{i} = RGB2(:,A1(i):A1(i+1),2);
%     BIm{i} = RGB2(:,A1(i):A1(i+1),3);
%     PcentR(i) = sum(RIm{i}(:))/sum(FullIm{i}(:));
%     PcentG(i) = sum(GIm{i}(:))/sum(FullIm{i}(:));
%     PcentB(i) = sum(BIm{i}(:))/sum(FullIm{i}(:));
%     data(i,:) = [PcentB(i), PcentR(i),PcentG(i)];
% end

figure();
bar(data*100,'stacked');
legend('healthy', 'damaged');
ylabel('Percent of tissue');
xlabel('Sample');





