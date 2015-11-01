load('twoFrameData', 'im1', 'im2', 'positions1','orients1','scales1','descriptors1','positions2','orients2','scales2','descriptors2');
    
disp(['Please select the region that you would like to recognize ' ...
          'in the second image']);
    
oninds = selectRegion(im1, positions1);

%patch_sifts = [];

%for i = (1:length(oninds))
%    patch_sifts(i, :) = descriptors1(i, :);
%end


patch_sifts = descriptors1(oninds, :);

common_indexs = matchRawDescriptors(patch_sifts, descriptors2)';

figure;
imshow(im2);
displaySIFTPatches(positions2(common_indexs, :), scales2(common_indexs), orients2(common_indexs), im2); 
