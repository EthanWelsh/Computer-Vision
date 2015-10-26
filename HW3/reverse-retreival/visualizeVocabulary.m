frame_sample_size =     300;
feature_sample_size =   100;

siftdir = ('~/Downloads/sift/');
framesdir = ('~/Downloads/frames/');

fnames = dir([siftdir '*.mat']);
frame_count = length(fnames);
random_frame_indecies = randperm(frame_count);

random_imnames =        [];
random_descriptors =    [];
random_positions =      [];
random_scales =         [];
random_orients =        [];

for i = (1:frame_sample_size)
    % Get the file name of a random frame
    fname = [siftdir '/' fnames(random_frame_indecies(i)).name];
    
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    
    [desc_len, ~] = size(descriptors);
    
    random_features_indexes = randperm(min(feature_sample_size, desc_len));
    
    for j = (1:length(random_features_indexes))
        % Hello, future Ethan. Here is where you need to write some code to
        % also keep track of the position, scale, and orient vectors... As
        % well as the IM associated with each image? Good luck...
        random_imnames =        [random_imnames;        imname];
        random_descriptors =    [random_descriptors;    descriptors(random_features_indexes(j), :)];
        random_positions =      [random_positions;      positions(random_features_indexes(j), :)];
        random_scales =         [random_scales;         scales(random_features_indexes(j), :)];
        random_orients =        [random_orients;        orients(random_features_indexes(j), :)];        
    end
end

if exist('centers.mat', 'file') == 2
    load('centers.mat', 'membership', 'means');
else
    [membership, means, ~] = kmeansML(1500, random_descriptors');
    save('centers.mat', 'membership', 'means');
end

if exist('two.mat', 'file') ~= 2
    
    [members_len, ~] = size(membership);

    words_to_compare_to_find_max_distance = 300;
    random_membership_indexes = randperm(members_len);

    max_distance = 0;

    w1 = [];
    w2 = [];

    for i = (1:words_to_compare_to_find_max_distance)

        word1_index = membership(random_membership_indexes(i));

        [member_count, ~] = size(membership(membership==word1_index));
        if member_count < 25
            continue
        end

        for j = (1:words_to_compare_to_find_max_distance)

            word2_index = membership(random_membership_indexes(j));

            [member_count, ~] = size(membership(membership==word2_index));
            if member_count < 25
                continue
            end

            word1 = random_descriptors(word1_index, :);
            word2 = random_descriptors(word2_index, :);

            distance_between_words = dist2(word1, word2);

            if distance_between_words > max_distance
                max_distance = distance_between_words;
                w1 = word1_index;
                w2 = word2_index;
            end
        end
    end
    save('two.mat', 'w1', 'w2');
else
   load('two.mat', 'w1', 'w2'); 
end

patches_chosen = 0;

w1_patches = (membership==w1)

w1_imnames =        random_imnames(w1_patches, :);
w1_descriptors =    random_descriptors(w1_patches, :);
w1_positions =      random_positions(w1_patches, :);
w1_scales =         random_scales(w1_patches, :);
w1_orients =        random_orients(w1_patches, :);

size(w1_imnames)
size(w1_descriptors)
size(w1_positions)
size(w1_scales)
size(w1_orients)

w1_imnames =        w1_imnames(1:25, :);
w1_descriptors =    w1_descriptors(1:25, :);
w1_positions =      w1_positions(1:25, :);
w1_scales =         w1_scales(1:25, :);
w1_orients =        w1_orients(1:25, :);

size(w1_imnames)
size(w1_descriptors)
size(w1_positions)
size(w1_scales)
size(w1_orients)

patches_w1 = [];

for i = (1:25)
    imname = [framesdir '/' w1_imnames(i, :)]; % add the full path
    img = imread(imname);
    patches_w1 = [patches_w1; getPatchFromSIFTParameters(w1_positions(i, :), w1_scales(i, :), w1_orients(i, :), img)];
end
