load('code/twoFrameData', 'im1', 'im2', 'positions1','orients1','scales1','descriptors1','positions2','orients2','scales2','descriptors2');
    
disp(['Please select the region that you would like to recognize ' ...
          'in the second image']);
    
oninds = selectRegion(im2, positions2);

patch_sifts = [];

for i = (1:length(oninds))
    patch_sifts(i, :) = descriptors2(i, :);
end

common_indexs = matchRawDescriptors(patch_sifts, descriptors2)'

figure;
imshow(im2);
displaySIFTPatches(positions2(common_indexs, :), scales2(common_indexs), orients2(common_indexs), im2); 
