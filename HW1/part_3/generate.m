function [ gaussian_img, laplacian_img ] = generate(img, level_number)
    
    % Convert image to grayscale
    gimg = rgb2gray(img);
    
    % Create the gaussian filter with hsize and sigma
    gaussian_filter = fspecial('gaussian',[15 15], 5);

    A = gimg;
    
    for i = [1 : level_number]     
        % Blur
        B = imfilter(A, gaussian_filter);
        
        % Half the size of both C and A
        C = subsample(B);     
        A = subsample(A);
        
        D = A - C;
        A = C;

    end
    
    % Resize images back to original size.  
    gaussian_img = B;
    laplacian_img = D;
    
    return;


end

function [half_img] = subsample(img)
% Half the size of an image
    [height, width] = size(img);

    small_w = round(width/2);
    small_h = round(height/2);
    
    half_img = uint8(0);
    half_img(small_h, small_w) = half_img;
    
    for r = 1:2:height
        for c = 1:2:width
            half_img( ((r-1)/2)+1, ((c-1)/2)+1 ) = img(r, c);
        end
    end
    
    return;
end