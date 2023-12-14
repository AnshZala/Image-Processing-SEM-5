% Fingerprint Minutiae Extraction without Machine Learning

% Read input fingerprint image
inputImage = imread('input_1.tif');

% Convert the image to grayscale if it's in color
if size(inputImage, 3) == 3
    inputImage = rgb2gray(inputImage);
end

% Enhance ridges using a filter (you can experiment with different filters)
ridgeEnhanced = imfilter(inputImage, fspecial('average', [5 5]));

% Binarize the image using adaptive thresholding
binaryImage = imbinarize(ridgeEnhanced, 'adaptive');

% Perform thinning to obtain ridges
thinnedImage = bwmorph(binaryImage, 'thin', Inf);

% Extract minutiae points
minutiaePoints = extractMinutiae(thinnedImage);

% Display the input and output images
figure;
subplot(1, 2, 1);
imshow(inputImage);
title('Input Fingerprint Image');

subplot(1, 2, 2);
imshow(thinnedImage);
hold on;
plot(minutiaePoints(:, 2), minutiaePoints(:, 1), 'r*');  % Display minutiae points
title('Thinned Image with Minutiae Points');
hold off;

function minutiaePoints = extractMinutiae(thinnedImage)
    % Skeletonize the thinned image to obtain ridge skeleton
    skeleton = bwmorph(thinnedImage, 'skel', Inf);

    % Find minutiae points
    [rows, cols] = find(bwmorph(skeleton, 'endpoints'));
    endPoints = [rows, cols];

    [rows, cols] = find(bwmorph(skeleton, 'branchpoints'));
    branchPoints = [rows, cols];

    % Combine endpoints and branchpoints as minutiae points
    minutiaePoints = [endPoints; branchPoints];
end
