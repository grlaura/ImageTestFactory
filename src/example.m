imgResolution = [480, 640];
prefix = 'image_';
saveDirectory = '../results/';
fileType = '.png';



% Generate all Black Image
pixelValue = 0;
img = createUnifImg(pixelValue, imgResolution);

% Save the image
saveNextImg (img, saveDirectory, prefix, fileType)

% Generate all White Image
pixelValue = 255;
img = createUnifImg(pixelValue, imgResolution);

% Save the image
saveNextImg (img, saveDirectory, prefix, fileType)

% Generate image with random values

% Set the random seed for reproducibility 

rng(0);

img = createRandImg(imgResolution, 0, 255);

% Save the image
saveNextImg (img, saveDirectory, prefix, fileType)



numBlobs = 10;           % Number of blobs
minBlobSize = 10;        % Minimum blob size (radius or diameter)
maxBlobSize = 30;        % Maximum blob size (radius or diameter)

img = createCirclesImg(imgResolution, numBlobs, minBlobSize, maxBlobSize);

% Save the image
saveNextImg (img, saveDirectory, prefix, fileType)


img = createBlobsImg(imgResolution, numBlobs, minBlobSize, maxBlobSize);



% Save the image
saveNextImg (img, saveDirectory, prefix, fileType)
