function [edges] = detectEdges(im, threshold)

im = im2double(rgb2gray(im));
im = imgaussfilt(im,.5);

% [gradient_magnitude, gradient_direction] = imgradient(im,'prewitt');

[height, width] = size(im);

n = 1;
edges = [];

average_magnitude = 0;

if(nargin==1)
    for r = (2:height-1)
        for c = (2:width-1)
    
            magnitude = sqrt((im(r, c + 1) - im(r, c - 1))^2 + (im(r + 1, c) - im(r - 1, c))^2);
            orientation = atand((im(r + 1, c) - im(r - 1, c))/(im(r, c + 1) - im(r, c - 1)));
            average_magnitude = average_magnitude + magnitude;
        end
    end

    average_magnitude = average_magnitude/(height*width);
    threshold = average_magnitude * 5;
    
end



for r = (2:height-1)
    for c = (2:width-1)
    
        magnitude = sqrt((im(r, c + 1) - im(r, c - 1))^2 + (im(r + 1, c) - im(r - 1, c))^2);
        orientation = atand((im(r + 1, c) - im(r - 1, c))/(im(r, c + 1) - im(r, c - 1)));
        average_magnitude = average_magnitude + magnitude;
        
        if magnitude > threshold
            edges(n, 1) = r;
            edges(n, 2) = c;
            edges(n, 3) = magnitude;
            edges(n, 4) = orientation;
            n = n + 1;
        end
    
    end
end

return
        
end