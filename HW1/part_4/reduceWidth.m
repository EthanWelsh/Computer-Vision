function [reducedColorImage,reducedEnergyImage] = reduceWidth(im, energyImage)
    
    [height, width, ~] = size(im); 
	
    M = cumulative_minimum_energy_map(energyImage, 'VERTICAL');
    verticalSeam = find_optimal_vertical_seam(M);
  
    reducedColorImage = zeros(height, width - 1, 3);
    reducedEnergyImage = zeros(height, width - 1);
    
     for r = 1:height
        for c = 1:verticalSeam(r)
            reducedColorImage(r, c, 1) = im(r, c, 1);
            reducedColorImage(r, c, 2) = im(r, c, 2);
            reducedColorImage(r, c, 3) = im(r, c, 3);

            reducedEnergyImage(r, c) = energyImage(r, c);  
        end
        
        for c = verticalSeam(r):(width - 1)  
            reducedColorImage(r, c, 1) = im(r, c + 1, 1);
            reducedColorImage(r, c, 2) = im(r, c + 1, 2);
            reducedColorImage(r, c, 3) = im(r, c + 1, 3);

            reducedEnergyImage(r, c) = energyImage(r, c + 1);  
        end
     end
 
    reducedColorImage = uint8(reducedColorImage);
     
    return
end

