frame_sample_size = 300;
feature_sample_size = 100;

siftdir = ('~/Downloads/sift/');
fnames = dir([siftdir '*.mat']);
frame_count = length(fnames);
random_frame_indecies = randperm(frame_count);

random_sift_indexes = [];

for i = (1:frame_sample_size)
    % Get the file name of a random frame
    fname = [siftdir '/' fnames(random_frame_indecies(i)).name];
    
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    
    [desc_len, ~] = size(descriptors);
    
    random_features_indexes = randperm(min(feature_sample_size, desc_len));
    
    for j = (1:length(random_features_indexes))
        random_sift_indexes = [random_sift_indexes; descriptors(random_features_indexes(j), :)];
    end
end

if exist('centers.mat', 'file') == 2
    load('centers.mat', 'membership', 'means');
else
    [membership, means, ~] = kmeansML(1500, random_sift_indexes');
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

            word1 = random_sift_indexes(word1_index, :);
            word2 = random_sift_indexes(word2_index, :);

            distance_between_words = dist2(word1, word2);

            if distance_between_words > max_distance
                max_distance = distance_between_words;
                w1 = word1;
                w2 = word2;
            end
        end
    end
    save('two.mat', 'w1', 'w2');
else
   load('two.mat', 'w1', 'w2'); 
end

