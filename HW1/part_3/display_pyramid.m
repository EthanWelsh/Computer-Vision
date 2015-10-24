function display_pyramid(image_name)

    img = imread(image_name);
    [height, width, ~] = size(img);
    
    
    figure;
    h = [];

    for i = 1:10;
        h(i) = subplot(2,5,i);
    end

    for i = 1:5; 
        [gaussian, laplacian] = generate(img, i); 
        
        gaussian = imresize(gaussian, [height, width], 'nearest'); 
        laplacian = imresize(laplacian, [height, width], 'nearest'); 
        
        imshow(gaussian,  'Parent', h(i));
        imshow(laplacian, 'Parent', h(i+5));
    end

end