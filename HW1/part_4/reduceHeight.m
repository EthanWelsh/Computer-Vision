function [reducedColorImage, reducedEnergyImage] = reduceHeight(im, energyImage)
    
    [height, width, ~] = size(im); 
    
    M = cumulative_minimum_energy_map(energyImage, 'HORIZONTAL');
    horizontalSeam = find_optimal_horizontal_seam(M);
    
    reducedColorImage = zeros(height - 1, width, 3);
    reducedEnergyImage = zeros(height - 1, width);

    for c = 1:width
        for r = 1:horizontalSeam(c)
           
            reducedColorImage(r, c, 1) = im(r, c, 1);
            reducedColorImage(r, c, 2) = im(r, c, 2);
            reducedColorImage(r, c, 3) = im(r, c, 3);

            reducedEnergyImage(r, c) = energyImage(r, c);  
        end
        for r = horizontalSeam(c):(height - 1)
            reducedColorImage(r, c, 1) = im(r + 1, c, 1);
            reducedColorImage(r, c, 2) = im(r + 1, c, 2);
            reducedColorImage(r, c, 3) = im(r + 1, c, 3);

            reducedEnergyImage(r, c) = energyImage(r + 1, c);  
        end
    end
      
    reducedColorImage = uint8(reducedColorImage);
    
    return
end

