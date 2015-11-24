load('model.mat', 'model_1', 'model_2');

test_dir = '~/Desktop/CS1699/HW/HW4/pedestrians/test_images';
listing = dir(test_dir);

positive = '~/Desktop/CS1699/HW/HW4/pedestrians/predicted/positive/';
negative = '~/Desktop/CS1699/HW/HW4/pedestrians/predicted/negative/';

test_images = {};

for i = (1 : length(listing))
    entry = listing(i);
    if ~entry.isdir && strcmp('.png', entry.name(length(entry.name) - 3:length(entry.name)))
        test_images{length(test_images) + 1} = rgb2gray(imread([test_dir '/' entry.name]));
    end
end

for image_index = (1 : length(test_images))
    
    image = test_images{image_index};  
    [height, width] = size(image);
  
    for c = (1:10:width - 96)
        for r = (1:10:height - 160)
            crop = imcrop(image, [c r 95 159]);
            feat = vl_hog(single(crop), 8);
            
            prediction_1 = predict(model_1, feat(:)');
            prediction_2 = predict(model_2, feat(:)');
            
            if prediction_1{1} == '+' && prediction_2{1} == '+'
                imwrite(crop, [positive num2str(image_index) '_' num2str(r) '_' num2str(c) '.png']);
            else
                imwrite(crop, [negative num2str(image_index) '_' num2str(r) '_' num2str(c) '.png']);
            end
        end
    end
    
end