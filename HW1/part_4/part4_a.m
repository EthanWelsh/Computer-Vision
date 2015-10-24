im = imread('http://people.cs.pitt.edu/~kovashka/cs1699/prague.jpg');

reducedEnergyImage = energy_image(im);
reducedColorImage = im;

for i = 1:100
    [reducedColorImage, reducedEnergyImage] = reduceHeight(reducedColorImage, reducedEnergyImage);
end

figure;
imshow(reducedColorImage);
saveas(gcf, 'part4_a-Prague_Seam_Resize.png');

[height, width, ~] = size(im);

figure;
imshow(imresize(im, [height-100 width]));
saveas(gcf, 'part4_a-Prague_MatLab_Resize.png');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

im = imread('http://people.cs.pitt.edu/~kovashka/cs1699/mall.jpg');

figure;
reducedEnergyImage = energy_image(im);
reducedColorImage = im;

for i = 1:100
    [reducedColorImage, reducedEnergyImage] = reduceWidth(reducedColorImage, reducedEnergyImage);
end

figure;
imshow(reducedColorImage);
saveas(gcf, 'part4_a-Mall_Seam_Resize.png');

[height, width, ~] = size(im);

figure;
imshow(imresize(im, [height width-100]));
saveas(gcf, 'part4_a-Mall_MatLab_Resize.png');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
