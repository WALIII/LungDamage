function RGB1 = XMASS_tish(GG1,GG2,GG3,F,T,HL);
% RGB overlay

% WAL3
% Dec 2018; Last revision: 12-Dec-2020

if nargin < 4
   %HL = [0.00005 .05];
   HL = [0.0001 .001];
   T = 1:size(GG1,2);
   F = 1:size(GG1,1);
elseif nargin < 6
   HL = [0.5 .95];
end

  HL = [0.50 .95];
Llim = HL(1);
 Hlim = HL(2);

im1(:,:,1)=  mat2gray(GG1);
im1(:,:,2)=  mat2gray(GG2);
im1(:,:,3)=  mat2gray(GG3);


RGB1 = imadjust(im1,[Llim Llim Llim; Hlim Hlim Hlim],[]);


image(T,F,(RGB1));set(gca,'YDir','normal');

title('baseleine to baseline')

