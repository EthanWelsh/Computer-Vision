function [edges] = detectEdges(im, threshold)

im = im2double(rgb2gray(im));
im = imgaussfilt(im,.5);

[gradient_magnitude, gradient_direction] = imgradient(im,'prewitt');

[height, width] = size(im);

n = 0
edges = []


for r = (1:height)
    for c = (1:width)
    
        magnitude = sqrt((gimg(r, c + 1) - gimg(r, c - 1))^2 + (gimg(r + 1, c) - gimg(r - 1, c))^2);
        orientatio = atand((gimg(r + 1, c) - gimg(r - 1, c))/(gimg(r, c + 1) - gimg(r, c - 1)));
        
        edges(n, 1) = r
        edges(n, 2) = c
        edges(n, 3) = magnitude
        edges(n, 4) = orientation
        
        
        
    end
        
end