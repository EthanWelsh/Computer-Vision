examples = 4;
query_size = 5;

siftdir = ('~/Downloads/sift/');

fnames = dir([siftdir '*.mat']);
frame_count = length(fnames);

siftdir = ('~/Downloads/sift/');
framesdir = ('~/Downloads/frames/');

fnames = dir([siftdir '*.mat']);
frame_count = length(fnames);
random_frame_indecies = randperm(frame_count);

bows = [];

% Load saved vocabular file
load('centers.mat', 'membership', 'means');


img_names = [];

for i = (1:frame_count)
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    img_names = [img_names; imname];
    
    bow = computeBOWRepr(descriptors, means);
    bows(i, :) = bow;
end

for example = (1:examples)
  
    results = []
    
    query_name = [siftdir '/' fnames(random_frame_indecies(example)).name];
    load(query_name, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    
    query_img = imread([framesdir '/' imname]);
    
    figure;
    oninds = selectRegion(query_img, positions);
    patch_sifts = descriptors(oninds, :);
    
    query_bow = computeBOWRepr(patch_sifts, means);
    
    for frame = (1:frame_count)
        frame_bow = bows(frame, :);
        dist_check = compareSimilarity(query_bow, frame_bow);
        
        if dist_check < 1
            results = [results; frame, dist_check];
        end
        
        
    end
    
    results = sortrows(results, -2);
    
    figure;
    for similar_image = (1:query_size)
        sim_index = results(similar_image, 1);
        sim_img = imread([framesdir '/' img_names(sim_index, :)]); 
        subplot(1, query_size, similar_image), imshow(sim_img);
    end
    
end