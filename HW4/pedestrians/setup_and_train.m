pos_dir = '~/Desktop/CS1699/HW/HW4/pedestrians/person_detection_training_data/pos/';
neg_dir = '~/Desktop/CS1699/HW/HW4/pedestrians/person_detection_training_data/neg/';

pos_paths = {};
neg_paths = {};

pos_listing = dir(pos_dir);
for i = (1 : length(pos_listing))
    pro = pos_listing(i);
    if ~pro.isdir && strcmp('.png', pro.name(length(pro.name) - 3:length(pro.name)))
        pos_paths{length(pos_paths) + 1} = [pos_dir pro.name];
    end
end

neg_listing = dir(neg_dir);
for i = (1 : length(neg_listing))
    neg = neg_listing(i);
    if ~neg.isdir && strcmp('.png', neg.name(length(neg.name) - 3:length(neg.name)))
        neg_paths{length(neg_paths) + 1} = [neg_dir neg.name];
    end
end

pos_imgs = {};
neg_imgs = {};

for i = (1 : length(pos_paths))
    pos_imgs{i} = rgb2gray(imread(pos_paths{i}));
end

[pos_height, pos_width] = size(rgb2gray(imread(pos_paths{1})));
while length(pos_imgs) ~= length(neg_imgs)
    rand_index = rand_int(1, length(neg_paths));
    rand_img = rgb2gray(imread(neg_paths{rand_index}));
    
    [height, width] = size(rand_img);
    
    xmin = rand_int(1, width - pos_width);
    ymin = rand_int(1, height - pos_height);
    
    neg_imgs{length(neg_imgs) + 1} = imcrop(rand_img, [xmin ymin pos_width pos_height]);
end

feats = [];
labels = {};

for i = (1 : length(neg_imgs))
    feat = vl_hog(single(pos_imgs{i}), 8);
    feats = [feats; feat(:)'];
    labels{length(labels) + 1} = '+';
        
    feat = vl_hog(single(neg_imgs{i}), 8);
    feats = [feats; feat(:)'];
    labels{length(labels) + 1} = '-';
end

model = fitcecoc(feats, labels);
save('model.mat', 'model')