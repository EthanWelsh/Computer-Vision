examples = 1;
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

frame_count = 100;

img_names = [];

for i = (1:frame_count)
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    img_names = [img_names; imname];
    
    bow = computeBOWRepr(descriptors, means);
    bows(i, :) = bow;
end

img_names


for example = (1:examples)
  
    results = []
    
    query_name = [siftdir '/' fnames(random_frame_indecies(example)).name];
    load(query_name, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    
    query_img = imread([framesdir '/' imname]);
    
    figure;
    imshow(query_img);
    
    query_bow = computeBOWRepr(descriptors, means);
    
    for frame = (1:frame_count)
        frame_bow = bows(i, :);
        results = [results; frame, compareSimilarity(query_bow, frame_bow)];
    end
    
    results = sortrows(results', 2);
    
    for similar_image = (1:query_size)
        sim_index = results(2, similar_image);
     
        sim_img = imread([framesdir '/' img_names(sim_index, :)]);
        
        subplot(1, query_size, similar_image), imshow(sim_img);
        
    end
    
end