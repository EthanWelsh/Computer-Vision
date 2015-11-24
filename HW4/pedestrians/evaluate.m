load('model.mat', 'model');

test_dir = '~/Desktop/CS1699/HW/HW4/pedestrians/test';
listing = dir(test_dir);

test_images = {};

for i = (1 : length(listing))
    entry = listing(i);
    if ~entry.isdir && strcmp('.png', entry.name(length(entry.name) - 3:length(entry.name)))
        test_images{length(test_images) + 1} = rgb2gray(imread([test_dir '/' entry.name]));
    end
end

pos = {};
neg = {};

for image_index = (1 : length(test_images))
    
    image = test_images{image_index};  
    [height, width] = size(image);
    
    pedestrian = 0;
    
    for c = (1:10:width - 96)
        for r = (1:10:height - 160)
            
            crop = imcrop(image, [c r 95 159]);
            
            size(crop)
            
            feat = vl_hog(single(crop), 8);
            
            if predict(model, feat(:)') == '+';
                pedestrian = 1;
                
                figure;
                imshow(crop);
            end
        end
    end
    
    if pedestrian == 1
        pos{length(pos) + 1} = image;
    else
        neg{length(neg) + 1} = image;
    end
end

pos
neg