function part4_c
    prague = imread('http://people.cs.pitt.edu/~kovashka/cs1699/prague.jpg');
    prague_energy = energy_image(prague);
    prague_vertical_cmep = cumulative_minimum_energy_map(prague_energy, 'VERTICAL');
    prague_horizontal_cmep = cumulative_minimum_energy_map(prague_energy, 'HORIZONTAL');

    prague_optimal_vertical = find_optimal_vertical_seam(prague_vertical_cmep);
    prague_optimal_horizontal = find_optimal_horizontal_seam(prague_horizontal_cmep);

    displaySeam(prague, prague_optimal_vertical, 'VERTICAL');
    saveas(gcf, 'prague_optimal_vertical.png');
    
    displaySeam(prague, prague_optimal_horizontal, 'HORIZONTAL');
    saveas(gcf, 'prague_optimal_horizontal.png');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    mall = imread('http://people.cs.pitt.edu/~kovashka/cs1699/mall.jpg');
    mall_energy = energy_image(mall);
    mall_vertical_cmep = cumulative_minimum_energy_map(mall_energy, 'VERTICAL');
    mall_horizontal_cmep = cumulative_minimum_energy_map(mall_energy, 'HORIZONTAL');

    mall_optimal_vertical = find_optimal_vertical_seam(mall_vertical_cmep);
    mall_optimal_horizontal = find_optimal_horizontal_seam(mall_horizontal_cmep);

    displaySeam(mall, mall_optimal_vertical, 'VERTICAL');
    saveas(gcf, 'mall_optimal_vertical.png');
    
    displaySeam(mall, mall_optimal_horizontal, 'HORIZONTAL');
    saveas(gcf, 'mall_optimal_horizontal.png');
end

function displaySeam(im, seam, seamDirection)
    
    [height, width, ~] = size(im);

    if strcmp(seamDirection, 'VERTICAL')
        figure;
        imshow(im);
        hold on;
        plot(seam, 1:height, 'r');
    end
    if strcmp(seamDirection, 'HORIZONTAL')
        figure;
        imshow(im);
        hold on;
        plot(1:width, seam, 'r');
    end
end

