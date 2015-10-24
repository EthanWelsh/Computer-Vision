function part4_d()
    wimbledon();
    nasa();
    belgium();
end

function wimbledon()

    im = imread('https://scontent.xx.fbcdn.net/hphotos-xpt1/v/t1.0-9/11707576_10204737410459526_6921292291590430081_n.jpg?oh=d6e0aa62b30179f71f2c91569e6b6510&oe=56A82E71');
    [height, width, ~] = size(im)
    
    figure;
    imshow(im)
    saveas(gcf, 'part4_d-wimbledon_original.png')
    
    reducedEnergyImage = energy_image(im);
    reducedColorImage = im;

    for i = 1:100
        [reducedColorImage, reducedEnergyImage] = reduceHeight(reducedColorImage, reducedEnergyImage);
    end

    figure;
    imshow(reducedColorImage);
    saveas(gcf, 'part4_d-wimbledon_seam.png');
    
    figure;
    imshow(imresize(im, [height-100 width]));
    saveas(gcf, 'part4_d-wimbledon_normal.png');

end

function nasa()

    im = imread('https://scontent.xx.fbcdn.net/hphotos-xpt1/v/t1.0-9/11998874_10205074897136482_68713016364860673_n.jpg?oh=c5807935071ddcf01a909521c4b9fe14&oe=569BE605');
    
    figure;
    imshow(im)
    saveas(gcf, 'part4_d-nasa_original.png')
    
    [height, width, ~] = size(im)
    
    reducedEnergyImage = energy_image(im);
    reducedColorImage = im;

    for i = 1:75
        [reducedColorImage, reducedEnergyImage] = reduceWidth(reducedColorImage, reducedEnergyImage);
    end

    figure;
    imshow(reducedColorImage);
    saveas(gcf, 'part4_d-nasa_seam.png');
    
    figure;
    imshow(imresize(im, [height-100 width]));
    saveas(gcf, 'part4_d-nasa_normal.png');
    
end

function belgium()

    im = imread('https://scontent.xx.fbcdn.net/hphotos-ash2/v/t1.0-9/944189_10151675367626214_759628643_n.jpg?oh=e12147fedb39e4fe20a9fc548d6a1fc5&oe=56663CCC');
    [height, width, ~] = size(im)
    
    figure;
    imshow(im)
    saveas(gcf, 'part4_d-belgium_original.png')
    
    reducedEnergyImage = energy_image(im);
    reducedColorImage = im;

    for i = 1:200
        [reducedColorImage, reducedEnergyImage] = reduceWidth(reducedColorImage, reducedEnergyImage);
    end

    figure;
    imshow(reducedColorImage);
    saveas(gcf, 'part4_d-belgium_seam.png');
    
    figure;
    imshow(imresize(im, [height-100 width]));
    saveas(gcf, 'part4_d-belgium_normal.png');

end
