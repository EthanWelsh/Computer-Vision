function [energyImage] = energy_image(im)
    
    im = im2double(rgb2gray(im));
    [height, width] = size(im);
    energyImage = double(0);
    energyImage(height, width) = energyImage;

    % For every pixel
	for r = 1:height
        for c = 1:width
            
            aa = 0;
            bb = 0;
            cc = 0;
            dd = 0;
            
            if r == 1
                cc = im(r, c);
            else
                cc = im(r - 1, c);
            end
            
            if c == 1
                bb = im(r, c);
            else
                bb = im(r, c - 1);
            end
            
            if r == height
                dd = im(r, c);
            else
                dd = im(r + 1, c);
            end
            
            if c == width
                aa = im(r, c);
            else
                aa = im(r, c + 1);
            end
            
            energyImage(r, c) = sqrt((aa - bb)^2 +(cc - dd)^2);
        end
    end
    
    return;
        
end