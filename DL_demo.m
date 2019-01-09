function DL_demo
% Plug and play... just run in a folder with the image you want.


% Get and Segment image...
[IM2] = DL_ImageSegment();

% Plot data...
figure(); 
  XMASS_tish(IM2(:,:,1),IM2(:,:,2),IM2(:,:,3));

% General Plotting...
RGB1 = DL_ImageStrat(IM2);