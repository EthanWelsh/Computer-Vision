function [im, descriptors, positions, scales, orients] = random_sift()
    siftdir = ('~/Downloads/sift/');
    framesdir = ('~/Downloads/frames/');

    fnames = dir([siftdir '*.mat']);
    frame_count = length(fnames);
    random_frame_index = randperm(frame_count);
    random_frame_index = random_frame_index(1);

    % Get the file name of a random frame
    fname = [siftdir '/' fnames(random_frame_index).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    im = imread([framesdir '/' imname]);
end

