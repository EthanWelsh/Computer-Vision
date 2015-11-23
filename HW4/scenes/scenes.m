[train, test] = get_data('~/Desktop/CS1699/HW/HW4/scenes/scene_categories', .10);
means = getBOW(train);

keys = {'bedroom', 'CALsuburb', 'industrial', 'kitchen', 'livingroom', 'MITcoast', 'MITforest', 'MIThighway', 'MITinsidecity', 'MITmountain', 'MITopencountry', 'MITstreet', 'MITtallbuilding', 'PARoffice', 'store'};
values = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
mapObj = containers.Map(keys, values);

training_pyramids = {};
training_labels = [];
testing_pyramids = {};
test_labels = [];

for i = (1 : length(train))
    
    training_labels = [training_labels mapObj(train(i).category)];
    
    im = imread(train(i).path);
    pyramid = computeSPMHistogram(im, means);
    
    training_pyramids{i} = pyramid;
end

for i = (1 : length(test))
    
    test_labels = [training_labels mapObj(test(i).category)];
    
    im = imread(test(i).path);
    pyramid = computeSPMHistogram(im, means);
    
    testing_pyramids{i} = pyramid;
end