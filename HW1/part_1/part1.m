% 1
a = 5;
R = a.*randn(1, 1000000);

% 2
[m, n] = size(R);

tic
    for i = (1:n)
        R(i) = R(i) + 1;
    end
toc

% 3
tic
    R = R + 1;
toc

% 4
rgb_img = imread('http://people.cs.pitt.edu/~kovashka/cs1699/Downtown_Pittsburgh_from_the_North_Shore.png');
[height, width] = size(rgb_img)

% 5
gray_img = rgb2gray(rgb_img);
[height, width] = size(gray_img);

%6
img_vector = gray_img(:);

min = 255;
index_of_min_pixel = 1;

[pixels_in_image, ~] = size(img_vector)

for i = (1:pixels_in_image)
    if img_vector(i) < min
        min = img_vector(i);
        index_of_min_pixel = i;
    end
end
min

%7
row_of_min = mod(index_of_min_pixel, height)
col_of_min = int32(index_of_min_pixel / height)
gray_img(row_of_min, col_of_min)

for r = (row_of_min - 15:row_of_min + 15)
    for c = (col_of_min - 15:col_of_min + 15)
        gray_img(r, c) = 255;
    end
end

figure;
imshow(gray_img);
saveas(gcf, 'part_1-8.png');