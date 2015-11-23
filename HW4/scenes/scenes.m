[train, test] = get_data('~/Desktop/CS1699/HW/HW4/scenes/scene_categories', .50);
means = getBOW(train);

keys = {'bedroom', 'CALsuburb', 'industrial', 'kitchen', 'livingroom', 'MITcoast', 'MITforest', 'MIThighway', 'MITinsidecity', 'MITmountain', 'MITopencountry', 'MITstreet', 'MITtallbuilding', 'PARoffice', 'store'};
values = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
mapObj = containers.Map(keys, values);

training_pyramids = {};
training_labels = {};
testing_pyramids = {};
test_labels = {};

for i = (1 : length(train))
    
    training_labels{i} = mapObj(train(i).category);
    
    im = imread(train(i).path);
    pyramid = computeSPMHistogram(im, means);
    
    training_pyramids{i} = pyramid;
end

for i = (1 : length(test))
    
    test_labels{i} = mapObj(test(i).category);
    
    im = imread(test(i).path);
    pyramid = computeSPMHistogram(im, means);
    
    testing_pyramids{i} = pyramid;
end

predicted_labels = findLabelsKNN(training_pyramids, testing_pyramids, training_labels, 1);
fprintf('%s: %f\n', 'KNN 1',    100.00 * computeAccuracy(test_labels, predicted_labels));

predicted_labels = findLabelsKNN(training_pyramids, testing_pyramids, training_labels, 5);
fprintf('%s: %f\n', 'KNN 5',    100.00 * computeAccuracy(test_labels, predicted_labels));

predicted_labels = findLabelsKNN(training_pyramids, testing_pyramids, training_labels, 25);
fprintf('%s: %f\n', 'KNN 25',   100.00 * computeAccuracy(test_labels, predicted_labels));

predicted_labels = findLabelsKNN(training_pyramids, testing_pyramids, training_labels, 100);
fprintf('%s: %f\n', 'KNN 100',  100.00 * computeAccuracy(test_labels, predicted_labels));

predicted_labels = findLabelsKNN(training_pyramids, testing_pyramids, training_labels, 125);
fprintf('%s: %f\n', 'KNN 125',  100.00 * computeAccuracy(test_labels, predicted_labels));

predicted_labels = findLabelsSVM(training_pyramids, testing_pyramids, training_labels);
fprintf('%s: %f\n', 'SVM',      100.00 * computeAccuracy(test_labels, predicted_labels));