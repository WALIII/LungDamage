function RGB1 = XMASS_tish(GG1,GG2,GG3,varargin);
% RGB overlay

% WAL3
% Dec 2018; Last revision: 12-Dec-2020

   T = 1:size(GG1,2);
   F = 1:size(GG1,1);
   HL = [0.05 .95];

% Manual inputs
vin=varargin;
for i=1:length(vin)
    if isequal(vin{i},'hl') % image type to pull from local directory
        HL=vin{i+1};
    elseif isequal(vin{i},'filer_sigma') % filter radius ( reduce for small images);
        sigma = vin{i+1};
    end
end

Llim = HL(1);
Hlim = HL(2);

im1(:,:,1)=  mat2gray(GG1);
im1(:,:,2)=  mat2gray(GG2);
im1(:,:,3)=  mat2gray(GG3);


RGB1 = imadjust(im1,[Llim Llim Llim; Hlim Hlim Hlim],[]);


image(T,F,(RGB1));set(gca,'YDir','normal');

title('baseline to baseline')

