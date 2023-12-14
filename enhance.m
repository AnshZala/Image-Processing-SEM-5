% Fingerprint Enhancement with Sharpening

% Read input fingerprint image
inputImage = imread('input_1.tif');

% Convert the image to grayscale if it's in color
if size(inputImage, 3) == 3
    inputImage = rgb2gray(inputImage);
end

% Enhance ridges using a filter (you can experiment with different filters)
ridgeEnhanced = imfilter(inputImage, fspecial('average', [5 5]));

% Sharpen the ridge-enhanced image using a sharpening filter
sharpened = imsharpen(ridgeEnhanced, 'Amount', 20, 'Radius', 25, 'Threshold', 0);

% Display the input and output images
figure;
subplot(1, 3, 1);
imshow(inputImage);
title('Input Fingerprint Image');

subplot(1, 3, 2);
imshow(ridgeEnhanced);
title('Ridge Enhanced Image');

subplot(1, 3, 3);
imshow(sharpened);
title('Sharpened Image');
