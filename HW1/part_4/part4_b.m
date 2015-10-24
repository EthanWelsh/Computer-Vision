prague = imread('http://people.cs.pitt.edu/~kovashka/cs1699/prague.jpg');

prague_energy = energy_image(prague);
figure('Name','Prague Energy','NumberTitle','off')
imshow(prague_energy);
saveas(gcf, 'part4_b-prague_energy.png');

prague_vertical_cmep = cumulative_minimum_energy_map(prague_energy, 'VERTICAL');
figure('Name','Prague Vertical CMEP','NumberTitle','off')
imagesc(prague_vertical_cmep);
saveas(gcf, 'part4_b-prague_vcmep.png');


prague_horizontal_cmep = cumulative_minimum_energy_map(prague_energy, 'HORIZONTAL');
figure('Name','Prague Horizontal CMEP','NumberTitle','off')
imagesc(prague_horizontal_cmep);
saveas(gcf, 'part4_b-prague_hcmep.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mall = imread('http://people.cs.pitt.edu/~kovashka/cs1699/mall.jpg');

mall_energy = energy_image(mall);
figure('Name','Mall Energy','NumberTitle','off')
imshow(mall_energy);
saveas(gcf, 'part4_b-mall_energy.png');

mall_vertical_cmep = cumulative_minimum_energy_map(mall_energy, 'VERTICAL');
figure('Name','Mall Vertical CMEP','NumberTitle','off')
imagesc(mall_vertical_cmep);
saveas(gcf, 'part4_b-mall_vcmep.png');

mall_horizontal_cmep = cumulative_minimum_energy_map(mall_energy, 'HORIZONTAL');
figure('Name','Mall Horizontal CMEP','NumberTitle','off')
imagesc(mall_horizontal_cmep);
saveas(gcf, 'part4_b-mall_hcmep.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%