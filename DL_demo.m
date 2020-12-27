function RGB1 = DL_demo
  %DL_demo.m - Plug-and-play Demo script to classify tussue damage for
  %                a single image
  %
  % Load in an image to process.
  %
  %
  % Syntax:  out = DL_demo
  %
  % Inputs:
  %    reference - name of referance image in local directory
  % Optional Inputs:
  %    type = image type (supports: PNG, jpeg,mat)
  %
  % Outputs:
  %    RGB1 - H*W*C ( height by width by cluster)
  %         RGB1(:,:,1) - Severly Damaged
  %         RGB1(:,:,2) - Moderatley Damaged
  %         RGB1(:,:,3) - Not Damaged
  %
  % Example:
  %    out = DL_demo % UI will allow you to select an image
  %
  % Other m-files required: none
  % Subfunctions: none
  % MAT-files required: DL_ImageSegment.m,  DL_ImageStrat.m
  %
  % See also: DL_demo_ref

  % Author: William Liberti (WAL3)
  % Work address: UC Berkeley
  % email: bliberti@bu.edu
  % Website: http://www.WALIII.github.io
  % Dec 2019; Last revision: 12-Dec-2020


% Get and Segment image...
[IM2] = DL_ImageSegment();

% Plot data...
figure();
  XMASS_tish(IM2(:,:,1),IM2(:,:,2),IM2(:,:,3));

% General Plotting...
RGB1 = DL_ImageStrat(IM2);
