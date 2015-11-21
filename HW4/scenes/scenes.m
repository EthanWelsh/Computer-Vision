[train, test] = get_data('~/Desktop/CS1699/HW/HW4/scenes/scene_categories', .10);
means = getBOW(train);

im = imread(train(1).path);

pyramid = computeSPMHistogram(im, means);